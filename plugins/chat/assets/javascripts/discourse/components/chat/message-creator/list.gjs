import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import concatClass from "discourse/helpers/concat-class";
import eq from "truth-helpers/helpers/eq";
import Action from "./action";
import Channel from "./channel";
import User from "./user";

export default class List extends Component {
  componentForItem(type) {
    switch (type) {
      case "action":
        return Action;
      case "user":
        return User;
      case "channel":
        return Channel;
    }
  }

  @action
  handleEnter(item, event) {
    if (event.key !== "Enter") {
      return;
    }

    if (event.shiftKey && this.args.onShiftSelect) {
      this.args.onShiftSelect?.(item);
    } else {
      this.args.onSelect?.(item);
    }
  }

  @action
  handleClick(item, event) {
    if (event.shiftKey && this.args.onShiftSelect) {
      this.args.onShiftSelect?.(item);
    } else {
      this.args.onSelect?.(item);
    }
  }

  <template>
    <div class="chat-message-creator__list-container">
      <ul class="chat-message-creator__list">
        {{#each @items as |item|}}
          <li
            class={{concatClass
              "chat-message-creator__list-item"
              (if
                (eq item.identifier @highlightedItem.identifier) "-highlighted"
              )
            }}
            {{on "click" (fn this.handleClick item)}}
            {{on "keypress" (fn this.handleEnter item)}}
            {{on "mouseenter" (fn @onHighlight item)}}
            {{on "mouseleave" (fn @onHighlight null)}}
            role="button"
            tabindex="0"
            data-identifier={{item.identifier}}
            id={{item.id}}
          >
            {{component (this.componentForItem item.type) item=item}}
          </li>
        {{/each}}
      </ul>
    </div>
  </template>
}
