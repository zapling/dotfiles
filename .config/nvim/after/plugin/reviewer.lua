-- Work in progress plugin that will be shared when it's in a usable state
require("reviewer").setup({
    providers = {
        gitlab_zimpler = {
            host = "gitlab.zimpler.com",
            get_provider = function()
                return require("reviewer.provider.gitlab")
            end,
            opts = {
                base_url = "https://gitlab.zimpler.com",
                access_token = os.getenv("ZIMPLER_GITLAB_REVIEWER_TOKEN")
            }
        }
    },
})
