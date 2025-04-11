package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.Material;

  use namespace alternativa3d;

  public class AnimSprite extends Sprite3D {
    private var _materials:Vector.<Material>;
    private var _frame:int = 0;
    private var _loop:Boolean = false;

    public function AnimSprite(param1:Number, param2:Number, param3:Vector.<Material> = null, param4:Boolean = false, param5:int = 0) {
      super(param1,param2);
      this._materials = param3;
      this._loop = param4;
      this.frame = param5;
    }

    public function get materials() : Vector.<Material> {
      return this._materials;
    }

    public function set materials(param1:Vector.<Material>) : void {
      this._materials = param1;
      if(param1 != null) {
        this.frame = this._frame;
      } else {
        material = null;
      }
    }

    public function get loop() : Boolean {
      return this._loop;
    }

    public function set loop(param1:Boolean) : void {
      this._loop = param1;
      this.frame = this._frame;
    }

    public function get frame() : int {
      return this._frame;
    }

    public function set frame(param1:int) : void {
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      this._frame = param1;
      if(this._materials != null) {
        local2 = int(this._materials.length);
        local3 = this._frame;
        if(this._frame < 0) {
          local4 = this._frame % local2;
          local3 = this._loop && local4 != 0 ? local4 + local2 : 0;
        } else if(this._frame > local2 - 1) {
          local3 = this._loop ? int(this._frame % local2) : local2 - 1;
        }
        material = this._materials[local3];
      }
    }

    override public function clone() : Object3D {
      var local1:AnimSprite = new AnimSprite(width,height);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:AnimSprite = param1 as AnimSprite;
      this._materials = local2._materials;
      this._loop = local2._loop;
      this._frame = local2._frame;
    }
  }
}
