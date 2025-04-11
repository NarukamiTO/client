package alternativa.tanks.display.usertitle {
  public class Size2D {
    public var width:int;
    public var height:int;

    public function Size2D() {
      super();
    }

    public function setToZero() : void {
      this.width = 0;
      this.height = 0;
    }

    public function setWidth(param1:int) : void {
      this.width = param1;
    }

    public function setHeight(param1:int) : void {
      this.height = param1;
    }

    public function setWidthIfGreater(param1:int) : void {
      if(this.width < param1) {
        this.width = param1;
      }
    }

    public function addHeight(param1:int) : void {
      this.height += param1;
    }

    public function addWidth(param1:int) : void {
      this.width += param1;
    }
  }
}
