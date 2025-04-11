package alternativa.tanks.gui.communication.button {
  import controls.buttons.IconButton;

  public class CommunicationPanelTabButton extends IconButton implements CommunicationPanelTabControl {
    private var category:String;

    public function CommunicationPanelTabButton(param1:String, param2:String, param3:Class) {
      super(param2,param3);
      this.category = param1;
    }

    public function getCategory() : String {
      return this.category;
    }
  }
}
