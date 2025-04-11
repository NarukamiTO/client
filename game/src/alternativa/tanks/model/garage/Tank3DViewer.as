package alternativa.tanks.model.garage {
  import alternativa.tanks.gui.tankpreview.TankPreviewWindow;
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import flash.display.BitmapData;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Tank3DViewer implements ITank3DViewer {
    [Inject]
    public static var itemService:ItemService;

    private var tankPreview:TankPreviewWindow;
    private var armorResource3DS:Tanks3DSResource;
    private var weaponResource3DS:Tanks3DSResource;
    private var droneResource3DS:Tanks3DSResource;
    private var color:BitmapData;
    private var animation:MultiframeTextureResource;
    private var isPreviewing:Boolean;

    public function Tank3DViewer() {
      super();
    }

    public function setView(param1:TankPreviewWindow) : void {
      this.tankPreview = param1;
      if(this.armorResource3DS != null) {
        this.tankPreview.setHull(this.armorResource3DS);
        this.armorResource3DS = null;
      }
      if(this.weaponResource3DS != null) {
        this.tankPreview.setTurret(this.weaponResource3DS);
        this.weaponResource3DS = null;
      }
      if(this.droneResource3DS != null) {
        this.tankPreview.setDrone(this.droneResource3DS);
        this.droneResource3DS = null;
      }
      if(this.color != null) {
        this.tankPreview.setColorMap(this.color);
        this.color = null;
      }
      if(this.animation != null) {
        this.tankPreview.setTextureAnimation(this.animation);
        this.animation = null;
      }
    }

    public function resetView() : void {
      this.tankPreview = null;
    }

    public function setArmor(param1:Tanks3DSResource) : void {
      if(this.tankPreview != null) {
        this.tankPreview.setHull(param1);
      } else {
        this.armorResource3DS = param1;
      }
    }

    public function setWeapon(param1:Tanks3DSResource) : void {
      if(this.tankPreview != null) {
        this.tankPreview.setTurret(param1);
      } else {
        this.weaponResource3DS = param1;
      }
    }

    public function setDrone(param1:Tanks3DSResource) : void {
      if(this.tankPreview != null) {
        this.tankPreview.setDrone(param1);
      } else {
        this.droneResource3DS = param1;
      }
    }

    public function setPreviewColor(param1:BitmapData) : void {
      this.isPreviewing = true;
      if(this.tankPreview != null) {
        this.tankPreview.setColorMap(param1);
      }
    }

    public function setColor(param1:BitmapData) : void {
      this.animation = null;
      this.color = param1;
      if(this.tankPreview != null) {
        this.tankPreview.setColorMap(param1);
      }
    }

    public function setPreviewAnimation(param1:MultiframeTextureResource) : void {
      this.isPreviewing = true;
      if(this.tankPreview != null) {
        this.tankPreview.setTextureAnimation(param1);
      }
    }

    public function setAnimation(param1:MultiframeTextureResource) : void {
      this.color = null;
      this.animation = param1;
      if(this.tankPreview != null) {
        this.tankPreview.setTextureAnimation(param1);
      }
    }

    public function closePreview() : void {
      if(!this.isPreviewing) {
        return;
      }
      this.isPreviewing = false;
      if(this.tankPreview == null) {
        return;
      }
      if(this.color != null) {
        this.tankPreview.setColorMap(this.color);
      }
      if(this.animation != null) {
        this.tankPreview.setTextureAnimation(this.animation);
      }
    }
  }
}
