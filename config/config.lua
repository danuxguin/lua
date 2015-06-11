-- configuration file for program 
-- define window size
--width = 200
--height = 300
--
if os.getenv("DISPLAY") == ":0.0" then
	width = 300; height = 300
else 
	width = 200; height = 200
end

BLUE = {r=0, g=0, b=1}
background = BLUE
