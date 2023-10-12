
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

game_manager := class(creative_device):

    @editable Button : button_device = button_device{}
    @editable Granter : item_granter_device = item_granter_device{}

    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(GiveItem)

    GiveItem(Agent:agent):void=
        Granter.GrantItem(Agent)