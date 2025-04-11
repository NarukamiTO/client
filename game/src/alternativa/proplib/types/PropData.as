package alternativa.proplib.types {
  public class PropData {
    private var _name:String;
    private var states:Object = {};

    public function PropData(name:String) {
      super();
      this._name = name;
    }

    public function get name() : String {
      return this._name;
    }

    public function addState(stateName:String, state:PropState) : void {
      this.states[stateName] = state;
    }

    public function getStateByName(stateName:String) : PropState {
      return this.states[stateName];
    }

    public function getDefaultState() : PropState {
      return this.states[PropState.DEFAULT_NAME];
    }

    public function toString() : String {
      return "[Prop name=" + this._name + "]";
    }

    public function traceProp() : void {
      var stateName:String = null;
      var state:PropState = null;
      trace("Prop",this._name);
      for(stateName in this.states) {
        state = this.states[stateName];
        trace("State",stateName);
        state.traceState();
      }
    }
  }
}
