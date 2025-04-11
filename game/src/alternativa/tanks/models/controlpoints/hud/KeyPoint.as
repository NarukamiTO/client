package alternativa.tanks.models.controlpoints.hud {
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.controlpoints.IDominationModel;
  import alternativa.tanks.models.controlpoints.sound.KeyPointSoundEffects;
  import alternativa.tanks.utils.MathUtils;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;

  public class KeyPoint implements Renderer, LogicUnit {
    private static const CON_SMOOTHING_FACTOR:ConsoleVarFloat = new ConsoleVarFloat("dom_smoothing_factor",0.95,0,1);
    private static const MAX_PROGRESS:Number = 100;

    private var id:int;
    private var name:String;
    private var captureState:ControlPointState;
    private var position:Vector3;
    private var view:KeyPointView;
    private var serverProgress:Number = 0;
    private var clientProgress:Number = 0;
    private var progressSpeed:Number = 0;
    private var controlPointsModel:IDominationModel;
    private var battleService:BattleService;
    private var updateForced:Boolean;
    private var soundEffects:KeyPointSoundEffects;

    public var tanksCount:int;

    public function KeyPoint(param1:int, param2:String, param3:Vector3, param4:BattleService, param5:IDominationModel, param6:KeyPointSoundEffects, param7:KeyPointView) {
      super();
      this.id = param1;
      this.name = param2;
      this.view = param7;
      this.position = param3;
      this.controlPointsModel = param5;
      this.soundEffects = param6;
      this.battleService = param4;
      this.updateForced = false;
      param4.getBattleScene3D().addRenderer(this,0);
      param7.addToScene(param4.getBattleScene3D(),param3);
    }

    public function setCaptureState(param1:ControlPointState) : void {
      this.captureState = param1;
      this.updateForced = false;
      if(this.captureState == ControlPointState.NEUTRAL) {
        this.view.becomeNeutral();
        if(this.tanksCount == 0) {
          this.serverProgress = 0;
          this.clientProgress = 0;
          this.progressSpeed = 0;
        }
      } else {
        if(this.captureState == ControlPointState.BLUE) {
          this.view.becomeBlue();
          this.serverProgress = MAX_PROGRESS;
        } else {
          this.view.becomeRed();
          this.serverProgress = -MAX_PROGRESS;
        }
        this.clientProgress = this.serverProgress;
        this.progressSpeed = 0;
      }
    }

    public function getCaptureState() : ControlPointState {
      return this.captureState;
    }

    public function setServerProgressData(param1:Number, param2:Number) : void {
      this.serverProgress = param1;
      this.progressSpeed = param2;
    }

    public function readPosition(param1:Vector3) : void {
      param1.copy(this.position);
      param1.z += KeyPointView.CIRCLE_ASCENSION;
    }

    public function getPosition() : Vector3 {
      return this.position;
    }

    public function getName() : String {
      return this.name;
    }

    public function getClientProgress() : Number {
      return this.clientProgress;
    }

    public function reset() : void {
      this.tanksCount = 0;
      this.serverProgress = 0;
      this.clientProgress = 0;
      this.progressSpeed = 0;
      this.captureState = ControlPointState.NEUTRAL;
      this.view.becomeNeutral();
      this.soundEffects.stopSound();
    }

    public function render(param1:int, param2:int) : void {
      this.view.update(this.clientProgress,this.battleService.getBattleScene3D().getCamera());
    }

    public function runLogic(param1:int, param2:int) : void {
      this.updateServerProgress(param2);
      this.udpateClientProgress();
      this.updateSound();
    }

    private function updateServerProgress(param1:int) : void {
      if(this.progressSpeed != 0) {
        this.serverProgress += this.progressSpeed * param1 / 1000;
        if(!this.updateForced && this.reachedMaximumProgress()) {
          this.controlPointsModel.forceUpdatePoint(this.id);
          this.updateForced = true;
        }
      }
    }

    private function udpateClientProgress() : void {
      var local1:Number = MathUtils.clamp(this.clientProgress + (this.serverProgress - this.clientProgress) * CON_SMOOTHING_FACTOR.value,-MAX_PROGRESS,MAX_PROGRESS);
      if(this.tanksCount == 0 && this.clientProgress * local1 <= 0) {
        this.serverProgress = 0;
        this.clientProgress = 0;
        this.progressSpeed = 0;
      } else {
        this.clientProgress = local1;
      }
    }

    private function reachedMaximumProgress() : Boolean {
      return Math.abs(this.serverProgress) >= MAX_PROGRESS;
    }

    private function updateSound() : void {
      var local1:Number = this.clientProgress * this.progressSpeed;
      if(local1 > 0 || this.clientProgress == 0 && this.progressSpeed != 0) {
        this.soundEffects.playActivationSound(this.position);
      } else if(local1 < 0) {
        this.soundEffects.playDeactivationSound(this.position);
      } else {
        this.soundEffects.stopSound();
      }
    }
  }
}
