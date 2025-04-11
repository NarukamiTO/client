package alternativa.tanks.battle.scene3d {
  import alternativa.tanks.battle.DeferredAction;

  public class DeferredRendererAddition implements DeferredAction {
    private var renderGroup:RenderGroup;
    private var renderer:Renderer;

    public function DeferredRendererAddition(param1:RenderGroup, param2:Renderer) {
      super();
      this.renderGroup = param1;
      this.renderer = param2;
    }

    public function execute() : void {
      this.renderGroup.addRenderer(this.renderer);
    }
  }
}
