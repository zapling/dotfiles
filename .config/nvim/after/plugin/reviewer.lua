require("reviewer").setup({
    providers = {
        zimpler_gitlab = {
            host = "gitlab.zimpler.com",
            get_provider = function()
                return require('reviewer.provider.gitlab')
            end,
            opts = {
                base_url = 'https://gitlab.zimpler.com',
                access_token = os.getenv('ZIMPLER_GITLAB_REVIEWER_TOKEN'),
            }
        }
    },
    debug = {
        logger = {
            use_file = true,
        }
    },
})
