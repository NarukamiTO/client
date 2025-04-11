package alternativa.tanks.gui.chat.dropdown {
  import alternativa.tanks.gui.communication.button.CommunicationPanelTabControl;
  import controls.dropdownlist.DropDownList;
  import flash.events.MouseEvent;

  public class ChatDropDownList extends DropDownList implements CommunicationPanelTabControl {
    private var isButtonMode:Boolean;
    private var category:String;

    public function ChatDropDownList(param1:String) {
      super();
      this.category = param1;
      height = 256;
      listWidthExtension = 30;
    }

    override protected function onButtonClick(param1:MouseEvent) : void {
      if(this.isButtonMode) {
        dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      } else {
        super.onButtonClick(param1);
      }
    }

    public function getCategory() : String {
      return this.category;
    }

    public function get enabled() : Boolean {
      return this.isButtonMode;
    }

    public function set enabled(param1:Boolean) : void {
      this.isButtonMode = param1;
    }
  }
}
