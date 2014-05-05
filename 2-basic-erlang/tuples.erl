-module(tuples).

-export([test/0]).

test() ->
    Persons = [{
        person, { "Joe", "Armstrong", [
            { shoesize, 42 },
            { pets, [ {
                cat, zorro
            }, {
                cat, daisy
            } ]},
            { children, [{
                thomas, 21
            }, {
                claire, 17
            } ]}
        ]}
    }, {
        person, { "Mike", "Williams", [
            { shoesize, 41 },
            { likes, [ boats, wine ]}
        ]}
    }],

    JoeAttributeList = [
        { shoesize, 42 },
        { pets, [ {
            cat, zorro
        }, {
            cat, daisy
        } ]},
        { children, [{
            thomas, 21
        }, {
            claire, 17
        } ]}
    ],

    JoeTuple = {
        person, { "Joe", "Armstrong", JoeAttributeList }
    },

    MikeAttributeList = [
        { shoesize, 41 },
        { likes, [ boats, wine ]}
    ],

    MikeTuple = {
        person, { "Mike", "Williams", MikeAttributeList}
    },

    Var = {person, "Francesco", "Cesarini"},
    {person, Name, Surname} = Var.