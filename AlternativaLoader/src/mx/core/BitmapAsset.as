package mx.core {
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.system.ApplicationDomain;

  use namespace mx_internal;

  public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject, ILayoutDirectionElement {
    private static var FlexVersionClass:Class;
    private static var MatrixUtilClass:Class;

    mx_internal static const VERSION:String = "4.6.0.23201";

    private var layoutFeaturesClass:Class;
    private var layoutFeatures:IAssetLayoutFeatures;
    private var _height:Number;
    private var _layoutDirection:String = "ltr";

    public function BitmapAsset(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false) {
      var local4:ApplicationDomain = null;
      super(param1,param2,param3);
      if(FlexVersionClass == null) {
        local4 = ApplicationDomain.currentDomain;
        if(local4.hasDefinition("mx.core::FlexVersion")) {
          FlexVersionClass = Class(local4.getDefinition("mx.core::FlexVersion"));
        }
      }
      if(Boolean(FlexVersionClass) && FlexVersionClass["compatibilityVersion"] >= FlexVersionClass["VERSION_4_0"]) {
        this.addEventListener(Event.ADDED,this.addedHandler);
      }
    }

    override public function get x() : Number {
      return this.layoutFeatures == null ? super.x : this.layoutFeatures.layoutX;
    }

    override public function set x(param1:Number) : void {
      if(this.x == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.x = param1;
      } else {
        this.layoutFeatures.layoutX = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get y() : Number {
      return this.layoutFeatures == null ? super.y : this.layoutFeatures.layoutY;
    }

    override public function set y(param1:Number) : void {
      if(this.y == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.y = param1;
      } else {
        this.layoutFeatures.layoutY = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get z() : Number {
      return this.layoutFeatures == null ? super.z : this.layoutFeatures.layoutZ;
    }

    override public function set z(param1:Number) : void {
      if(this.z == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.z = param1;
      } else {
        this.layoutFeatures.layoutZ = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get width() : Number {
      var local1:Point = null;
      if(this.layoutFeatures == null) {
        return super.width;
      }
      if(MatrixUtilClass != null) {
        local1 = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth,this._height,transform.matrix);
      }
      return !!local1 ? local1.x : super.width;
    }

    override public function set width(param1:Number) : void {
      if(this.width == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.width = param1;
      } else {
        this.layoutFeatures.layoutWidth = param1;
        this.layoutFeatures.layoutScaleX = this.measuredWidth != 0 ? param1 / this.measuredWidth : 0;
        this.validateTransformMatrix();
      }
    }

    override public function get height() : Number {
      var local1:Point = null;
      if(this.layoutFeatures == null) {
        return super.height;
      }
      if(MatrixUtilClass != null) {
        local1 = MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth,this._height,transform.matrix);
      }
      return !!local1 ? local1.y : super.height;
    }

    override public function set height(param1:Number) : void {
      if(this.height == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.height = param1;
      } else {
        this._height = param1;
        this.layoutFeatures.layoutScaleY = this.measuredHeight != 0 ? param1 / this.measuredHeight : 0;
        this.validateTransformMatrix();
      }
    }

    override public function get rotationX() : Number {
      return this.layoutFeatures == null ? super.rotationX : this.layoutFeatures.layoutRotationX;
    }

    override public function set rotationX(param1:Number) : void {
      if(this.rotationX == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.rotationX = param1;
      } else {
        this.layoutFeatures.layoutRotationX = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get rotationY() : Number {
      return this.layoutFeatures == null ? super.rotationY : this.layoutFeatures.layoutRotationY;
    }

    override public function set rotationY(param1:Number) : void {
      if(this.rotationY == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.rotationY = param1;
      } else {
        this.layoutFeatures.layoutRotationY = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get rotationZ() : Number {
      return this.layoutFeatures == null ? super.rotationZ : this.layoutFeatures.layoutRotationZ;
    }

    override public function set rotationZ(param1:Number) : void {
      if(this.rotationZ == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.rotationZ = param1;
      } else {
        this.layoutFeatures.layoutRotationZ = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get rotation() : Number {
      return this.layoutFeatures == null ? super.rotation : this.layoutFeatures.layoutRotationZ;
    }

    override public function set rotation(param1:Number) : void {
      if(this.rotation == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.rotation = param1;
      } else {
        this.layoutFeatures.layoutRotationZ = param1;
        this.validateTransformMatrix();
      }
    }

    override public function get scaleX() : Number {
      return this.layoutFeatures == null ? super.scaleX : this.layoutFeatures.layoutScaleX;
    }

    override public function set scaleX(param1:Number) : void {
      if(this.scaleX == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.scaleX = param1;
      } else {
        this.layoutFeatures.layoutScaleX = param1;
        this.layoutFeatures.layoutWidth = Math.abs(param1) * this.measuredWidth;
        this.validateTransformMatrix();
      }
    }

    override public function get scaleY() : Number {
      return this.layoutFeatures == null ? super.scaleY : this.layoutFeatures.layoutScaleY;
    }

    override public function set scaleY(param1:Number) : void {
      if(this.scaleY == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.scaleY = param1;
      } else {
        this.layoutFeatures.layoutScaleY = param1;
        this._height = Math.abs(param1) * this.measuredHeight;
        this.validateTransformMatrix();
      }
    }

    override public function get scaleZ() : Number {
      return this.layoutFeatures == null ? super.scaleZ : this.layoutFeatures.layoutScaleZ;
    }

    override public function set scaleZ(param1:Number) : void {
      if(this.scaleZ == param1) {
        return;
      }
      if(this.layoutFeatures == null) {
        super.scaleZ = param1;
      } else {
        this.layoutFeatures.layoutScaleZ = param1;
        this.validateTransformMatrix();
      }
    }

    public function get layoutDirection() : String {
      return this._layoutDirection;
    }

    public function set layoutDirection(param1:String) : void {
      if(param1 == this._layoutDirection) {
        return;
      }
      this._layoutDirection = param1;
      this.invalidateLayoutDirection();
    }

    public function get measuredHeight() : Number {
      if(bitmapData) {
        return bitmapData.height;
      }
      return 0;
    }

    public function get measuredWidth() : Number {
      if(bitmapData) {
        return bitmapData.width;
      }
      return 0;
    }

    public function invalidateLayoutDirection() : void {
      var local2:Boolean = false;
      var local1:DisplayObjectContainer = parent;
      while(local1) {
        if(local1 is ILayoutDirectionElement) {
          local2 = this._layoutDirection != null && ILayoutDirectionElement(local1).layoutDirection != null && this._layoutDirection != ILayoutDirectionElement(local1).layoutDirection;
          if(local2 && this.layoutFeatures == null) {
            this.initAdvancedLayoutFeatures();
            if(this.layoutFeatures != null) {
              this.layoutFeatures.mirror = local2;
              this.validateTransformMatrix();
            }
          } else if(!local2 && Boolean(this.layoutFeatures)) {
            this.layoutFeatures.mirror = local2;
            this.validateTransformMatrix();
            this.layoutFeatures = null;
          }
          break;
        }
        local1 = local1.parent;
      }
    }

    public function move(param1:Number, param2:Number) : void {
      this.x = param1;
      this.y = param2;
    }

    public function setActualSize(param1:Number, param2:Number) : void {
      this.width = param1;
      this.height = param2;
    }

    private function addedHandler(param1:Event) : void {
      this.invalidateLayoutDirection();
    }

    private function initAdvancedLayoutFeatures() : void {
      var local1:ApplicationDomain = null;
      var local2:IAssetLayoutFeatures = null;
      if(this.layoutFeaturesClass == null) {
        local1 = ApplicationDomain.currentDomain;
        if(local1.hasDefinition("mx.core::AdvancedLayoutFeatures")) {
          this.layoutFeaturesClass = Class(local1.getDefinition("mx.core::AdvancedLayoutFeatures"));
        }
        if(MatrixUtilClass == null) {
          if(local1.hasDefinition("mx.utils::MatrixUtil")) {
            MatrixUtilClass = Class(local1.getDefinition("mx.utils::MatrixUtil"));
          }
        }
      }
      if(this.layoutFeaturesClass != null) {
        local2 = new this.layoutFeaturesClass();
        local2.layoutScaleX = this.scaleX;
        local2.layoutScaleY = this.scaleY;
        local2.layoutScaleZ = this.scaleZ;
        local2.layoutRotationX = this.rotationX;
        local2.layoutRotationY = this.rotationY;
        local2.layoutRotationZ = this.rotation;
        local2.layoutX = this.x;
        local2.layoutY = this.y;
        local2.layoutZ = this.z;
        local2.layoutWidth = this.width;
        this._height = this.height;
        this.layoutFeatures = local2;
      }
    }

    private function validateTransformMatrix() : void {
      if(this.layoutFeatures != null) {
        if(this.layoutFeatures.is3D) {
          super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
        } else {
          super.transform.matrix = this.layoutFeatures.computedMatrix;
        }
      }
    }
  }
}
