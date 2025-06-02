import Component from "@ember/component";
import { classNames } from "@ember-decorators/component";
import { modifier as modifierFn } from "ember-modifier";
import { or } from "truth-helpers";
import htmlSafe from "discourse/helpers/html-safe";

const YEAR = new Date().getFullYear();

const adjustMinHeight = modifierFn(() => {
  const headerHeight = document.querySelector(".d-header-wrap").offsetHeight;
  const footerHeight = document.querySelector(
    ".below-footer-outlet"
  ).offsetHeight;
  const mainOutletStyles = getComputedStyle(
    document.querySelector("#main-outlet")
  );
  const mainOutletPaddingTop = parseInt(
    mainOutletStyles.getPropertyValue("padding-top"),
    10
  );
  if (headerHeight && footerHeight && mainOutletPaddingTop) {
    const mainOffset = headerHeight + footerHeight + mainOutletPaddingTop + 1;
    document.querySelector("#main-outlet").style.minHeight =
      "calc(100vh - " + mainOffset + "px)";
  }
});

@classNames("below-footer-outlet", "minimal-footer")
export default class MinimalFooter extends Component {
  <template>
    {{#if this.showFooter}}
      <footer {{adjustMinHeight}} class="discourse-minimal-footer">
        <div class="discourse-minimal-footer-content">
          {{#if settings.footer_logo}}
            <div class="discourse-minimal-footer-logo">
              <a
                href={{settings.footer_logo_url}}
                target="_blank"
                rel="noopener noreferrer"
              >
                <img src={{settings.footer_logo}} />
              </a>
            </div>
          {{/if}}

          {{#if settings.footer_html_a}}
            <p class="discourse-minimal-footer-row-a">
              {{htmlSafe settings.footer_html_a}}
            </p>
          {{/if}}

          {{#if settings.footer_html_b}}
            <p class="discourse-minimal-footer-row-b">
              {{htmlSafe settings.footer_html_b}}
            </p>
          {{/if}}

          {{#if (or settings.show_copyright settings.footer_html_c)}}
            <p class="discourse-minimal-footer-row-c">
              {{#if settings.show_copyright}}
                &copy;
                {{YEAR}}
              {{/if}}
              {{#if settings.footer_html_c}}
                {{htmlSafe settings.footer_html_c}}
              {{/if}}
            </p>
          {{/if}}
        </div>
      </footer>
    {{/if}}
  </template>
}
