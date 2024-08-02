local job = require("plenary.job")
local Config = require("jayjay.config")

local Api = {}

Api.COMPLETIONS_URL = "https://api.openai.com/v1/completions"
Api.EDITS_URL = "https://api.openai.com/v1/edits"
-- API KEY
Api.OPENAI_API_KEY = ""-- os.getenv("OPENAI_API_KEY")
if not Api.OPENAI_API_KEY then
  error("OPENAI_API_KEY environment variable not set")
end

function Api.make_call(url, params, cb)
  Api.job = job
    :new({
      command = "curl",
      args = {
        url,
        "-H",
        "Content-Type: application/json",
        "-H",
        "Authorization: Bearer " .. Api.OPENAI_API_KEY,
        "-d",
        vim.fn.json_encode(params),
      },
      on_exit = vim.schedule_wrap(function(response, exit_code)
        Api.handle_response(response, exit_code, cb)
      end),
    })
    :start()
end

function Api.explainCode(code, cb)
  local params = vim.tbl_extend("keep", {prompt = code}, {
      model = "code-davinci-002",
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 300,
      temperature = 0,
      top_p = 1,
      n = 1,
      stop = "\"\"\""
    })
  print(params)
  Api.make_call(Api.COMPLETIONS_URL, params, cb)
end

function Api.completions(custom_params, cb)
  local params = vim.tbl_extend("keep", custom_params, Config.options.openai_params)
  Api.make_call(Api.COMPLETIONS_URL, params, cb)
end

Api.handle_response = vim.schedule_wrap(function(response, exit_code, cb)
  print("handle response: ", response)
  if exit_code ~= 0 then
    vim.notify("An Error Occurred ...", vim.log.levels.ERROR)
    cb("ERROR: API Error")
  end

  local result = table.concat(response:result(), "\n")
  local json = vim.fn.json_decode(result)
  for k, v in ipairs(json) do
    print("KEY: ", k,"- VALUE: ", v)
  end
  print("json: ", json)
  if json == nil then
    cb("No Response.")
  elseif json.error then
    cb("// API ERROR: " .. json.error.message)
  else
    local response_text = json.choices[1].text
    print("response_text: ", response_text)
    if type(response_text) == "string" and response_text ~= "" then
      cb(response_text, json.usage)
    else
      cb("...")
    end
  end
end)

function Api.close()
  if Api.job then
    job:shutdown()
  end
end

return Api
