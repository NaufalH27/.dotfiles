import Quickshell.Io

JsonObject {
    property Service service: Service {}
    property Ui ui: Ui {}

    component Service: JsonObject {
        // 0 is 24hour without a date
        // 1 is ampm without a date
        // 2 is 24hour with a date
        // 3 is ampm with a date
        property int clockFormat: 2
        property int numberOfClockFormat: 4
    }
    component Ui: JsonObject {
        property int minNumberOfPillShown: 5
        property int maxNumberOfPillShown: 10

    }
}
