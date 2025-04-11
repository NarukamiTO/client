package alternativa.tanks.gui.friends.list.renderer.background {
  import alternativa.tanks.gui.friends.list.ClanMembersList;

  public class RendererBackGroundClanMembersList extends RendererBackGroundAcceptedList {
    public function RendererBackGroundClanMembersList(param1:Boolean, param2:Boolean = false) {
      super(param1,param2);
    }

    override protected function isScroll() : Boolean {
      return ClanMembersList.scrollOn;
    }
  }
}
