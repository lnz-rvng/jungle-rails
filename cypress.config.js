const { defineConfig } = require("cypress");

module.exports = defineConfig({
  // setupNodeEvents can be defined in either
  // the e2e or component configuration
  // e2e: {
  //   setupNodeEvents(on, config) {
  //     on('before:browser:launch', (browser = {}, launchOptions) => {

  //     })
  //   },
  // },
  screenshotsFolder: "tmp/cypress_screenshots",
  viewportHeight: 1440,
  viewportWidth: 2160,
  videosFolder: "tmp/cypress_videos",
  // trashAssetsBeforeRuns: false,

  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
