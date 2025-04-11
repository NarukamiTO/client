package alternativa.proplib.types {
  public class PropGroup {
    public var name:String;
    public var props:Vector.<PropData>;
    public var groups:Vector.<PropGroup>;

    public function PropGroup(name:String) {
      super();
      this.name = name;
    }

    public function getPropByName(propName:String) : PropData {
      var prop:PropData = null;
      if(this.props == null) {
        return null;
      }
      for each(prop in this.props) {
        if(prop.name == propName) {
          return prop;
        }
      }
      return null;
    }

    public function getGroupByName(groupName:String) : PropGroup {
      var group:PropGroup = null;
      if(this.groups == null) {
        return null;
      }
      for each(group in this.groups) {
        if(group.name == groupName) {
          return group;
        }
      }
      return null;
    }

    public function addProp(prop:PropData) : void {
      if(this.props == null) {
        this.props = new Vector.<PropData>();
      }
      this.props.push(prop);
    }

    public function addGroup(group:PropGroup) : void {
      if(this.groups == null) {
        this.groups = new Vector.<PropGroup>();
      }
      this.groups.push(group);
    }

    public function traceGroup() : void {
      var group:PropGroup = null;
      var prop:PropData = null;
      trace("=== Group " + this.name + " ===");
      if(this.groups != null) {
        for each(group in this.groups) {
          group.traceGroup();
        }
      }
      if(this.props != null) {
        for each(prop in this.props) {
          prop.traceProp();
        }
      }
    }
  }
}
