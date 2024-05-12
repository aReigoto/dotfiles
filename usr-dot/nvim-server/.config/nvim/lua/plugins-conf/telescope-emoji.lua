local status_ok, telescope_emoji = pcall(require, "telescope-emoji")
if not status_ok then
  print("telescope emoji not found")
	return
end

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension('emoji')

