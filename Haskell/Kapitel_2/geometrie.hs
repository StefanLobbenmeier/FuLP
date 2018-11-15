data Punkt 
  = Punkt Float Float
  deriving (Show)
data ZweiDObjekt 
  = Kreis Punkt Float
  | Rechteck Punkt Punkt
  | Dreieck Punkt Punkt Punkt
  deriving (Show)


flaeche :: ZweiDObjekt -> Float
flaeche (Kreis _ r) = pi * r^2
flaeche (Rechteck (Punkt x1 y1) (Punkt x2 y2)) = (abs (x1-x2)) * (abs (y1-y2))
flaeche (Dreieck (Punkt x1 y1) (Punkt x2 y2) (Punkt x3 y3)) =
  abs (1/2 * (x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2)))

k1 = Kreis (Punkt 1.2 4.3) 1.2
k2 = Kreis (Punkt 3.2 2.6) 1.0

r1 = Rechteck (Punkt 3.0 2.0) (Punkt 4.0 4.0)

d1 = Dreieck (Punkt 0 0) (Punkt 0 1) (Punkt 1 0)
d2 = Dreieck (Punkt 1 1) (Punkt 2 3) (Punkt 1 3)

-- Präsenzaufgabe
svg_liste = [domics
  Rechteck (Punkt 10 10) (Punkt 20 20),
  Rechteck (Punkt 20 20) (Punkt 40 40),
  Kreis (Punkt 40 40) 20,
  Dreieck (Punkt 40 40) (Punkt 60 40) (Punkt 40 60) 
  ]

main = writeFile "geometrie.svg" (export_svg svg_liste)

export_svg :: [ZweiDObjekt] -> String
export_svg obj = 
  surround_svg_objects_with_svg_overhead (
  foldr (++) "" 
  (map surround_svg_param_with_svg_style 
  (map transform_2dobj_to_svg_param obj)
  )
  )

float_to_str :: Float -> String
float_to_str f = 
  "\"" ++ show f ++ "\" "

point_to_str :: Punkt -> String
point_to_str (Punkt x y) = 
  show x ++ "," ++ show y ++ " "

transform_2dobj_to_svg_param :: ZweiDObjekt -> String
transform_2dobj_to_svg_param (Kreis (Punkt x y) r) =
  "circle " ++
  "cx = " ++ float_to_str x ++ 
  "cy = " ++ float_to_str y ++ 
  "r = " ++ float_to_str r
transform_2dobj_to_svg_param (Rechteck (Punkt x1 y1) (Punkt x2 y2)) =
  "rect " ++
  "x = " ++ float_to_str x1 ++ 
  "y = " ++ float_to_str y1 ++ 
  "width = " ++ float_to_str (x2-x1) ++ 
  "height = " ++ float_to_str (y2-y1)
transform_2dobj_to_svg_param (Dreieck p1 p2 p3) =
  transform_points_to_svg_poly [p1, p2, p3, p1]

transform_points_to_svg_poly :: [Punkt] -> String
transform_points_to_svg_poly points = 
  "polyline points=\"" ++
  foldr (++) "" (map point_to_str points)++
  "\" "


surround_svg_param_with_svg_style :: String -> String
surround_svg_param_with_svg_style svg_param = 
  "<" ++
  svg_param ++
  "\n style=\"stroke:black;strocke-wisth:3;fill:none\" />\n"


surround_svg_objects_with_svg_overhead :: String -> String
surround_svg_objects_with_svg_overhead svg = 
  "<?xml version=\"1.0\"?>\n" ++
  "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\"\n" ++
  "\"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n" ++
  "<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\">\"\n" ++
  svg ++
  "\n</svg>"
