// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  runtimeConfig: {
    public: {
        whisperingApiHost: process.env.WHISPERING_API_HOST || 'http://localhost:8000'
    }
  }
})
