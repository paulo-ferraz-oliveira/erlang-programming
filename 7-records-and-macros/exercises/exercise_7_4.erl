-module(exercise_7_4).

-export([perimeter/1, area/1]).
-export([circle/1, rectangle/2, triangle/3]).

-include("exercise_7_4.hrl").

circle(Radius) ->
    #circle{radius = Radius}.

rectangle(Width, Length) ->
    #rectangle{width = Width, length = Length}.

triangle(Side1, Side2, Side3) ->
    #triangle{side1 = Side1, side2 = Side2, side3 = Side3}.

perimeter(Shape) when is_record(Shape, circle) ->
    P = 2 * Shape#circle.radius,
    {ok, P};
perimeter(Shape) when is_record(Shape, rectangle) ->
    P = 2 * (Shape#rectangle.length + Shape#rectangle.width),
    {ok, P};
perimeter(Shape) when is_record(Shape, triangle) ->
    P = (Shape#triangle.side1 + Shape#triangle.side2 + Shape#triangle.side3) / 2,
    {ok, P};
perimeter(_) ->
    {error, invalid_shape}.

area(Shape) when is_record(Shape, circle) ->
    A = math:pi() * math:pow(Shape#circle.radius, 2),
    {ok, A};
area(Shape) when is_record(Shape, rectangle) ->
    A = Shape#rectangle.width * Shape#rectangle.length,
    {ok, A};
area(Shape) when is_record(Shape, triangle) ->
    {ok, P} = perimeter(Shape),
    A = math:sqrt(P * (P - Shape#triangle.side1) * (P - Shape#triangle.side2) * (P - Shape#triangle.side3)),
    {ok, A};
area(_) ->
    {error, invalid_shape}.