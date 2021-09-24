import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  setupComponent(args, component) {
    component.set("theYear", new Date().getFullYear());
    if (document.querySelector(".discourse-minimal-footer")) {
      let footerHeight = document.querySelector(".discourse-minimal-footer")
        .offsetHeight;
      component.set("footerHeight", footerHeight);
    }

    withPluginApi("0.8.7", (api) => {
      api.decoratePluginOutlet("below-footer", (elem, args) => {
        let headerHeight = document.querySelector(".d-header-wrap")
          .offsetHeight;
        let footerHeight = document.querySelector(".below-footer-outlet")
          .offsetHeight;
        let mainOutletStyles = getComputedStyle(
          document.querySelector("#main-outlet")
        );
        let mainOutletPaddingTop = parseInt(
          mainOutletStyles.getPropertyValue("padding-top"),
          10
        );

        if (headerHeight && footerHeight && mainOutletPaddingTop) {
          let mainOffset =
            headerHeight + footerHeight + mainOutletPaddingTop + 1;
          document.querySelector("#main-outlet").style.minHeight =
            "calc(100vh - " + mainOffset + "px)";
        }
      });
    });
  },
};
