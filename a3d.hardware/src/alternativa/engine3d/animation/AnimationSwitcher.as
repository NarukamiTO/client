package alternativa.engine3d.animation {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class AnimationSwitcher extends AnimationNode {
    private var _numAnimations:int = 0;
    private var _animations:Vector.<AnimationNode> = new Vector.<AnimationNode>();
    private var _weights:Vector.<Number> = new Vector.<Number>();
    private var _active:AnimationNode;
    private var fadingSpeed:Number = 0;

    public function AnimationSwitcher() {
      super();
    }

    override alternativa3d function update(param1:Number, param2:Number) : void {
      var local6:AnimationNode = null;
      var local7:Number = NaN;
      var local3:Number = speed * param1;
      var local4:Number = this.fadingSpeed * local3;
      var local5:int = 0;
      while(local5 < this._numAnimations) {
        local6 = this._animations[local5];
        local7 = this._weights[local5];
        if(local6 == this._active) {
          local7 += local4;
          local7 = local7 >= 1 ? 1 : local7;
          local6.alternativa3d::update(local3,param2 * local7);
          this._weights[local5] = local7;
        } else {
          local7 -= local4;
          if(local7 > 0) {
            local6.alternativa3d::update(local3,param2 * local7);
            this._weights[local5] = local7;
          } else {
            local6.alternativa3d::_isActive = false;
            this._weights[local5] = 0;
          }
        }
        local5++;
      }
    }

    public function get active() : AnimationNode {
      return this._active;
    }

    public function activate(param1:AnimationNode, param2:Number = 0) : void {
      var local3:int = 0;
      if(param1.alternativa3d::_parent != this) {
        throw new Error("Animation is not child of this blender");
      }
      this._active = param1;
      param1.alternativa3d::_isActive = true;
      if(param2 <= 0) {
        local3 = 0;
        while(local3 < this._numAnimations) {
          if(this._animations[local3] == param1) {
            this._weights[local3] = 1;
          } else {
            this._weights[local3] = 0;
            this._animations[local3].alternativa3d::_isActive = false;
          }
          local3++;
        }
        this.fadingSpeed = 0;
      } else {
        this.fadingSpeed = 1 / param2;
      }
    }

    override alternativa3d function setController(param1:AnimationController) : void {
      var local3:AnimationNode = null;
      this.alternativa3d::controller = param1;
      var local2:int = 0;
      while(local2 < this._numAnimations) {
        local3 = this._animations[local2];
        local3.alternativa3d::setController(alternativa3d::controller);
        local2++;
      }
    }

    override alternativa3d function removeNode(param1:AnimationNode) : void {
      this.removeAnimation(param1);
    }

    public function addAnimation(param1:AnimationNode) : AnimationNode {
      if(param1 == null) {
        throw new Error("Animation cannot be null");
      }
      if(param1.alternativa3d::_parent == this) {
        throw new Error("Animation already exist in blender");
      }
      this._animations[this._numAnimations] = param1;
      if(this._numAnimations == 0) {
        this._active = param1;
        param1.alternativa3d::_isActive = true;
        this._weights[this._numAnimations] = 1;
      } else {
        this._weights[this._numAnimations] = 0;
      }
      ++this._numAnimations;
      alternativa3d::addNode(param1);
      return param1;
    }

    public function removeAnimation(param1:AnimationNode) : AnimationNode {
      var local2:int = int(this._animations.indexOf(param1));
      if(local2 < 0) {
        throw new ArgumentError("Animation not found");
      }
      --this._numAnimations;
      var local3:int = local2 + 1;
      while(local2 < this._numAnimations) {
        this._animations[local2] = this._animations[local3];
        local2++;
        local3++;
      }
      this._animations.length = this._numAnimations;
      this._weights.length = this._numAnimations;
      if(this._active == param1) {
        if(this._numAnimations > 0) {
          this._active = this._animations[int(this._numAnimations - 1)];
          this._weights[int(this._numAnimations - 1)] = 1;
        } else {
          this._active = null;
        }
      }
      super.alternativa3d::removeNode(param1);
      return param1;
    }

    public function getAnimationAt(param1:int) : AnimationNode {
      return this._animations[param1];
    }

    public function numAnimations() : int {
      return this._numAnimations;
    }
  }
}
