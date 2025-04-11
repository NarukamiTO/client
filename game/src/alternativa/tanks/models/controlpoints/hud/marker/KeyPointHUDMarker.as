package alternativa.tanks.models.controlpoints.hud.marker {
  import alternativa.math.Vector3;
  import alternativa.tanks.models.controlpoints.hud.KeyPoint;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.PixelSnapping;
  import flash.display.Sprite;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;
  import utils.graphics.SectorMask;

  public class KeyPointHUDMarker extends Sprite {
    private var keyPoint:KeyPoint;
    private var imageBlue:Bitmap;
    private var imageRed:Bitmap;
    private var sectorMask:SectorMask;
    private var score:Number = 0;
    private var container:Sprite = new Sprite();

    public function KeyPointHUDMarker(param1:KeyPoint) {
      super();
      this.keyPoint = param1;
      this.createImages();
    }

    private static function createMarkerBitmap(param1:ControlPointState) : Bitmap {
      return new Bitmap(MarkerBitmaps.getMarkerBitmapData(param1),PixelSnapping.AUTO,true);
    }

    private function createImages() : void {
      this.imageBlue = createMarkerBitmap(ControlPointState.BLUE);
      this.imageRed = createMarkerBitmap(ControlPointState.RED);
      addChild(createMarkerBitmap(ControlPointState.NEUTRAL));
      addChild(this.container);
      this.sectorMask = new SectorMask(this.imageBlue.width);
      this.container.addChild(this.sectorMask);
      addChild(new Bitmap(MarkerBitmaps.getLetterImage(this.keyPoint.getName().charAt(0))));
      this.paintItGray();
    }

    public function readPosition3D(param1:Vector3) : void {
      this.keyPoint.readPosition(param1);
    }

    public function update() : void {
      this.setScore(this.keyPoint.getClientProgress());
    }

    public function getKeyPoint() : KeyPoint {
      return this.keyPoint;
    }

    private function setScore(param1:Number) : void {
      var local2:Number = NaN;
      if(param1 < -100) {
        param1 = -100;
      } else if(param1 > 100) {
        param1 = 100;
      }
      if(this.score != param1) {
        if(param1 == 0) {
          this.paintItGray();
        } else {
          local2 = Math.abs(param1) / 100;
          this.sectorMask.setProgress(1 - local2,1);
          if(param1 < 0) {
            this.paintItRed();
          } else if(param1 > 0) {
            this.paintItBlue();
          }
        }
        this.score = param1;
      }
    }

    private function paintItGray() : void {
      this.container.visible = false;
    }

    private function paintItRed() : void {
      this.container.visible = true;
      this.swapObjects(this.imageBlue,this.imageRed);
      this.container.mask = this.sectorMask;
    }

    private function paintItBlue() : void {
      this.container.visible = true;
      this.swapObjects(this.imageRed,this.imageBlue);
      this.container.mask = this.sectorMask;
    }

    private function swapObjects(param1:DisplayObject, param2:DisplayObject) : void {
      if(param2.parent == null) {
        if(param1.parent != null) {
          this.container.removeChild(param1);
        }
        this.container.addChild(param2);
      }
    }
  }
}
