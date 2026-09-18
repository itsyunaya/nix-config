-- see https://rmpc.mierak.dev/rmpcd/

local config = {
	address = "127.0.0.1:6600",
	mpris = true,
}

local secrets_path = "/home/ashley/.config/lastfm.txt"

if fs.exists(secrets_path) then
	local file = fs.read_str(secrets_path)
	local api_key, shared_secret = file:match("([^\n]+)\n([^\n]+)")

	rmpcd.install("#builtin.lastfm"):setup({
		api_key = api_key,
		shared_secret = shared_secret,
		update_now_playing = true,
	})
else
	log.warn("LastFM secrets file does not exist. Please create ~/.config/lastfm.txt")
end

return config
