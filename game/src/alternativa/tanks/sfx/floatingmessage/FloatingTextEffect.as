package alternativa.tanks.sfx.floatingmessage {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.*;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.geom.Vector3D;

  public class FloatingTextEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private static const vector1:Vector3D = new Vector3D();

    private var messageLifeTime:int;
    private var messages:Vector.<Message>;
    private var anchor:Object3D;
    private var messageContainer:DisplayObjectContainer;
    private var destructionCallback:Function;
    private var killed:Boolean;

    public function FloatingTextEffect(param1:Pool) {
      super(param1);
      this.messages = new Vector.<Message>();
      this.messageContainer = new Sprite();
    }

    public function init(param1:int, param2:Object3D, param3:Function) : void {
      this.messageLifeTime = param1;
      this.anchor = param2;
      this.destructionCallback = param3;
      this.killed = false;
    }

    public function addMessage(param1:String, param2:uint) : void {
      var local3:Message = Message.create();
      local3.color = param2;
      local3.text = param1;
      local3.lifeTime = 0;
      this.messages.push(local3);
      this.messageContainer.addChild(local3);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      battleService.getBattleView().addOverlayObject(this.messageContainer);
    }

    public function kill() : void {
      this.killed = true;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:int = 0;
      var local6:Message = null;
      if(this.killed) {
        return false;
      }
      local3 = 0;
      while(local3 < this.messages.length) {
        local6 = this.messages[local3];
        local6.lifeTime += param1;
        if(local6.lifeTime >= this.messageLifeTime) {
          local6.destroy();
          this.messages.shift();
          local3--;
        }
        local3++;
      }
      if(this.messages.length == 0) {
        return false;
      }
      vector1.x = 0;
      vector1.y = 0;
      vector1.z = 0;
      var local4:Vector3D = param2.projectGlobal(this.anchor.localToGlobal(vector1));
      if(local4.z > 0.01 && local4.z > param2.nearClipping) {
        this.messageContainer.visible = true;
        this.messageContainer.x = int(local4.x);
        this.messageContainer.y = int(local4.y);
      } else {
        this.messageContainer.visible = false;
      }
      var local5:int = 0;
      local3 = this.messages.length - 1;
      while(local3 >= 0) {
        local6 = this.messages[local3];
        local6.y = local5;
        local6.x = -int(local6.textWidth / 2);
        local5 -= 20;
        local3--;
      }
      return true;
    }

    public function destroy() : void {
      var local1:Message = null;
      var local2:Function = null;
      if(this.messageContainer.parent != null) {
        this.messageContainer.parent.removeChild(this.messageContainer);
      }
      for each(local1 in this.messages) {
        local1.destroy();
      }
      this.messages.length = 0;
      if(this.destructionCallback != null) {
        local2 = this.destructionCallback;
        this.destructionCallback = null;
        local2.call();
      }
    }
  }
}
