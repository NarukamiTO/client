package projects.tanks.clients.fp10.libraries.tanksservices.service.group {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;

  public class GroupInfoService extends EventDispatcher implements IGroupInfoService {
    private var group:Vector.<Long> = new Vector.<Long>();
    private var _hasGroups:Boolean = false;

    public function GroupInfoService() {
      super();
    }

    public function addGroupUser(param1:Long) : * {
      this._hasGroups = true;
      this.group.push(param1);
    }

    public function isInSameGroup(param1:Long) : Boolean {
      return this.group.indexOf(param1) != -1;
    }

    public function hasGroups() : Boolean {
      return this._hasGroups;
    }

    public function setHasGroups(param1:Boolean) : * {
      this._hasGroups = param1;
    }
  }
}
