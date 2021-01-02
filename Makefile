
CONVERT := inkscape -w 1404 -h 1872
OBJ := dailyplanner_jens.png dailyplanner_kristin.png

.PHONY: upload

all: $(OBJ)

$(OBJ): %.png : %.svg
	$(CONVERT) $(basename $@).svg -o $@

upload: $(OBJ)
	scp *.svg *.png templates.json $(HOST):/usr/share/remarkable/templates/
