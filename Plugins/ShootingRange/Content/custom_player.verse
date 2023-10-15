
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

custom_player := class<unique>():
    
    Player : player

    var Eliminations <private> : int = 0

    AwardElimination():void =
        set Eliminations += 1

    GetEliminationCount()<transacts>:int =
        return Eliminations
