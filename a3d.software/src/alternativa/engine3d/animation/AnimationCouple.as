package alternativa.engine3d.animation {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class AnimationCouple extends AnimationNode {
    private var _left:AnimationNode;
    private var _right:AnimationNode;

    public var balance:Number = 0.5;

    public function AnimationCouple() {
      super();
    }

    override alternativa3d function update(param1:Number, param2:Number) : void {
      var local3:Number = this.balance <= 0 ? 0 : (this.balance >= 1 ? 1 : this.balance);
      if(this._left == null) {
        this._right.alternativa3d::update(param1 * speed,param2);
      } else if(this._right == null) {
        this._left.alternativa3d::update(param1 * speed,param2);
      } else {
        this._left.alternativa3d::update(param1 * speed,(1 - local3) * param2);
        this._right.alternativa3d::update(param1 * speed,local3 * param2);
      }
    }

    override alternativa3d function setController(param1:AnimationController) : void {
      this.alternativa3d::controller = param1;
      if(this._left != null) {
        this._left.alternativa3d::setController(param1);
      }
      if(this._right != null) {
        this._right.alternativa3d::setController(param1);
      }
    }

    override alternativa3d function addNode(param1:AnimationNode) : void {
      super.alternativa3d::addNode(param1);
      param1.alternativa3d::_isActive = true;
    }

    override alternativa3d function removeNode(param1:AnimationNode) : void {
      if(this._left == param1) {
        this._left = null;
      } else {
        this._right = null;
      }
      super.alternativa3d::removeNode(param1);
    }

    public function get left() : AnimationNode {
      return this._left;
    }

    public function set left(param1:AnimationNode) : void {
      if(param1 != this._left) {
        if(param1.alternativa3d::_parent == this) {
          throw new Error("Animation already exist in  blender");
        }
        if(this._left != null) {
          this.alternativa3d::removeNode(this._left);
        }
        this._left = param1;
        if(param1 != null) {
          this.alternativa3d::addNode(param1);
        }
      }
    }

    public function get right() : AnimationNode {
      return this._right;
    }

    public function set right(param1:AnimationNode) : void {
      if(param1 != this._right) {
        if(param1.alternativa3d::_parent == this) {
          throw new Error("Animation already exist in blender");
        }
        if(this._right != null) {
          this.alternativa3d::removeNode(this._right);
        }
        this._right = param1;
        if(param1 != null) {
          this.alternativa3d::addNode(param1);
        }
      }
    }
  }
}
