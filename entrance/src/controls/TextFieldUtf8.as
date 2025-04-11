package controls {
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.TextEvent;
  import flash.system.Capabilities;
  import flash.text.TextField;

  public class TextFieldUtf8 extends TextField {
    private static const NOTHING:int = -1;
    private static const INVALID:int = -2;

    private var character:int = 0;
    private var bits_left:int = 0;
    private var utf32_char:int = -1;

    public function TextFieldUtf8() {
      super();
      if(Boolean(Capabilities.os.search("Linux") != -1 && int((Capabilities.version.split(" ")[1] as String).split(",")[0]) < 10) && Capabilities.playerType != "StandAlone") {
        addEventListener(TextEvent.TEXT_INPUT,this.textInputHandler,false,1);
        addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,1);
      }
    }

    private function utf8Decode(param1:int) : int {
      if(this.bits_left == 0) {
        if((param1 & 0x80) == 0) {
          return param1 & 0x7F;
        }
        if((param1 & 0xE0) == 192) {
          this.character = (param1 & 0x1F) << 6;
          this.bits_left = 6;
        } else if((param1 & 0xF0) == 224) {
          this.character = (param1 & 0x0F) << 12;
          this.bits_left = 12;
        } else if((param1 & 0xF8) == 240) {
          this.character = (param1 & 7) << 18;
          this.bits_left = 18;
        } else if((param1 & 0xFC) == 248) {
          this.character = (param1 & 3) << 24;
          this.bits_left = 24;
        } else {
          if((param1 & 0xFE) != 252) {
            return INVALID;
          }
          this.character = (param1 & 1) << 30;
          this.bits_left = 30;
        }
        return NOTHING;
      }
      if((param1 & 0xC0) != 128) {
        return INVALID;
      }
      this.bits_left -= 6;
      this.character |= (param1 & 0x3F) << this.bits_left;
      if(this.bits_left == 0) {
        return this.character;
      }
      if(this.bits_left > 30) {
        this.bits_left = 0;
        return INVALID;
      }
      return NOTHING;
    }

    private function keyDownHandler(param1:KeyboardEvent) : void {
      this.utf32_char = this.utf8Decode(param1.charCode);
    }

    private function textInputHandler(param1:TextEvent) : void {
      var local2:String = null;
      var local3:String = null;
      var local4:int = 0;
      if(this.utf32_char == 10 && !this.multiline) {
        param1.preventDefault();
        param1.stopImmediatePropagation();
        return;
      }
      if(param1.text.length == 1) {
        if(this.utf32_char != NOTHING && this.utf32_char != INVALID) {
          if(this.selectionBeginIndex == this.selectionEndIndex) {
            local2 = this.text.substr(0,this.caretIndex);
            local3 = this.text.substr(this.caretIndex);
            local4 = this.caretIndex + 1;
          } else {
            local2 = this.text.substr(0,this.selectionBeginIndex);
            local3 = this.text.substr(this.selectionEndIndex);
            local4 = this.selectionBeginIndex + 1;
          }
          param1.text = this.text = local2 + String.fromCharCode(this.utf32_char) + local3;
          this.setSelection(local4,local4);
          this.dispatchEvent(new Event(Event.CHANGE));
        } else {
          param1.stopImmediatePropagation();
        }
        param1.preventDefault();
      }
    }
  }
}
