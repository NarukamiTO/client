package alternativa.tanks.models.battle.assault {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
  import alternativa.tanks.models.controlpoints.hud.KeyPointView;
  import alternativa.tanks.models.teamlight.ModeLight;
  import alternativa.tanks.models.teamlight.TeamLightColor;
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import flash.geom.Point;
  import flash.geom.Vector3D;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class PointBaseIndicatorPlane extends Mesh implements Renderer {
    [Inject]
    public static var lightingEffectsService:ILightingEffectsService;

    public static const CIRCLE_SIZE:Number = 1000;

    private var battleService:BattleService;
    private var material:Material;
    private var _faces:Vector.<Face>;
    private var uvs:Vector.<Point> = new Vector.<Point>();
    private var verts:Vector.<Vector3D> = new Vector.<Vector3D>();
    private var lightSource:OmniLight;
    private var indicatorStateProvider:PointIndicatorStateProvider;

    public function PointBaseIndicatorPlane(param1:BattleTeam, param2:Material, param3:BattleService, param4:PointIndicatorStateProvider) {
      super();
      this.indicatorStateProvider = param4;
      this.material = param2;
      this.battleService = param3;
      useShadowMap = false;
      useLight = false;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      this.createGeometry();
      if(param1 != null) {
        this.initLight(param1);
      }
      this.setPosition();
      param3.getBattleScene3D().addObjectToExclusion(this);
    }

    private function createGeometry() : void {
      var local1:Vertex = null;
      var local2:Vertex = null;
      var local3:Vertex = null;
      var local4:Number = CIRCLE_SIZE * 0.5;
      var local5:Number = CIRCLE_SIZE * 0.5;
      this.verts[0] = new Vector3D(0,local5,0);
      this.verts[1] = new Vector3D(-local4,0,0);
      this.verts[2] = new Vector3D(0,-local5,0);
      this.verts[3] = new Vector3D(local4,0,0);
      this.uvs[0] = new Point(0.5,-0.5);
      this.uvs[1] = new Point(-0.5,0.5);
      this.uvs[2] = new Point(0.5,1.5);
      this.uvs[3] = new Point(1.5,0.5);
      this._faces = new Vector.<Face>();
      local1 = this.createVertex(-local4,0,0,-0.5,0.5);
      local2 = this.createVertex(0,0,0,0.5,0.5);
      local3 = this.createVertex(0,local5,0,0.5,-0.5);
      this._faces[0] = this.createFace(local1,local2,local3,this.material);
      local1 = this.createVertex(0,-local5,0,0.5,1.5);
      local2 = this.createVertex(0,0,0,0.5,0.5);
      local3 = this.createVertex(-local4,0,0,-0.5,0.5);
      this._faces[1] = this.createFace(local1,local2,local3,this.material);
      local1 = this.createVertex(local4,0,0,1.5,0.5);
      local2 = this.createVertex(0,0,0,0.5,0.5);
      local3 = this.createVertex(0,-local5,0,0.5,1.5);
      this._faces[2] = this.createFace(local1,local2,local3,this.material);
      local1 = this.createVertex(0,local5,0,0.5,-0.5);
      local2 = this.createVertex(0,0,0,0.5,0.5);
      local3 = this.createVertex(local4,0,0,1.5,0.5);
      this._faces[3] = this.createFace(local1,local2,local3,this.material);
      local1 = this.createVertex(0,0,0,0,0);
      local2 = this.createVertex(0,0,0,0.5,0.5);
      local3 = this.createVertex(0,0,0,0,0);
      this._faces[4] = this.createFace(local1,local2,local3,this.material);
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      local6.next = vertexList;
      vertexList = local6;
      return local6;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : Face {
      var local5:Face = null;
      local5 = new Face();
      local5.material = param4;
      local5.wrapper = new Wrapper();
      local5.wrapper.vertex = param1;
      local5.wrapper.next = new Wrapper();
      local5.wrapper.next.vertex = param2;
      local5.wrapper.next.next = new Wrapper();
      local5.wrapper.next.next.vertex = param3;
      local5.normalX = 0;
      local5.normalY = 0;
      local5.normalZ = 1;
      local5.offset = 0;
      local5.next = faceList;
      faceList = local5;
      return local5;
    }

    public function updateRotation(param1:Camera3D) : void {
      rotationX = param1.rotationX - Math.PI;
      rotationY = 0;
      rotationZ = param1.rotationZ;
    }

    public function render(param1:int, param2:int) : void {
      visible = this.indicatorStateProvider.isIndicatorActive();
      if(Boolean(this.lightSource)) {
        this.lightSource.visible = visible;
      }
      this.setPosition();
      this.updateRotation(this.battleService.getBattleScene3D().getCamera());
    }

    private function setPosition() : void {
      var local1:Vector3 = this.indicatorStateProvider.getIndicatorPosition();
      x = local1.x;
      y = local1.y;
      z = local1.z + KeyPointView.CIRCLE_ASCENSION;
      if(Boolean(this.lightSource)) {
        this.lightSource.x = x;
        this.lightSource.y = y;
        this.lightSource.z = z;
      }
    }

    private function initLight(param1:BattleTeam) : void {
      var local2:ModeLight = lightingEffectsService.getLightForMode(BattleMode.CP);
      var local3:TeamLightColor = local2.getLightForTeam(param1);
      this.lightSource = new OmniLight(0,local2.getAttenuationBegin(),local2.getAttenuationEnd());
      this.lightSource.color = local3.getColor();
      this.lightSource.intensity = local3.getIntensity();
      this.battleService.getBattleScene3D().addObject(this.lightSource);
    }
  }
}
