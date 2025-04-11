package alternativa.tanks.battle.scene3d {
  import alternativa.tanks.battle.*;

  public class RenderGroup {
    private var renderers:Vector.<Renderer> = new Vector.<Renderer>();
    private var size:int;
    private var rendering:Boolean;

    private const deferredActions:Vector.<DeferredAction> = new Vector.<DeferredAction>();

    public function RenderGroup() {
      super();
    }

    public function addRenderer(param1:Renderer) : void {
      if(this.rendering) {
        this.deferredActions.push(new DeferredRendererAddition(this,param1));
      } else if(this.renderers.indexOf(param1) < 0) {
        var local2:* = this.size++;
        this.renderers[local2] = param1;
      }
    }

    public function removeRenderer(param1:Renderer) : void {
      var local2:int = 0;
      if(this.rendering) {
        this.deferredActions.push(new DeferredRendererDeletion(this,param1));
      } else {
        local2 = int(this.renderers.indexOf(param1));
        if(local2 >= 0) {
          this.renderers[local2] = this.renderers[--this.size];
          this.renderers[this.size] = null;
        }
      }
    }

    public function render(param1:int, param2:int) : void {
      var local4:Renderer = null;
      this.rendering = true;
      var local3:int = 0;
      while(local3 < this.size) {
        local4 = this.renderers[local3];
        local4.render(param1,param2);
        local3++;
      }
      this.rendering = false;
      this.executeDeferredActions();
    }

    private function executeDeferredActions() : void {
      var local1:DeferredAction = null;
      while(true) {
        local1 = this.deferredActions.pop();
        if(local1 == null) {
          break;
        }
        local1.execute();
      }
    }
  }
}
