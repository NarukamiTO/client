package alternativa.tanks.models.panel.create {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.space.createclan.ClanCreateModelBase;
  import projects.tanks.client.clans.space.createclan.IClanCreateModelBase;

  [ModelInfo]
  public class ClanCreateModel extends ClanCreateModelBase implements IClanCreateModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var createClanService:ClanCreateService;

    public function ClanCreateModel() {
      super();
    }

    public function objectLoaded() : void {
      createClanService.addEventListener(CreateClanServiceEvent.CREATE,getFunctionWrapper(this.onCreateClan));
      createClanService.addEventListener(CreateClanServiceEvent.VALIDATE_NAME,getFunctionWrapper(this.validateClanName));
      createClanService.addEventListener(CreateClanServiceEvent.VALIDATE_TAG,getFunctionWrapper(this.validateClanTag));
    }

    private function onCreateClan(param1:CreateClanServiceEvent) : void {
      server.createClan(param1.clanName,param1.clanTag,param1.clanFlag.id);
    }

    private function validateClanName(param1:CreateClanServiceEvent) : void {
      server.validateName(param1.clanName);
    }

    private function validateClanTag(param1:CreateClanServiceEvent) : void {
      server.validateTag(param1.clanTag);
    }

    public function nameIsIncorrect() : void {
      createClanService.incorrectName();
    }

    public function notUniqueName() : void {
      createClanService.notUniqueName();
    }

    public function notUniqueTag() : void {
      createClanService.notUniqueTag();
    }

    public function tagIsIncorrect() : void {
      createClanService.incorrectTag();
    }

    public function correctName() : void {
      createClanService.correctName();
    }

    public function correctTag() : void {
      createClanService.correctTag();
    }

    public function otherError() : void {
      createClanService.otherError();
    }

    public function alreadyInClan() : void {
      createClanService.alreadyInClan();
    }

    public function objectUnloaded() : void {
      createClanService.removeEventListener(CreateClanServiceEvent.CREATE,getFunctionWrapper(this.onCreateClan));
      createClanService.removeEventListener(CreateClanServiceEvent.VALIDATE_NAME,getFunctionWrapper(this.validateClanName));
      createClanService.removeEventListener(CreateClanServiceEvent.VALIDATE_TAG,getFunctionWrapper(this.validateClanTag));
    }
  }
}
