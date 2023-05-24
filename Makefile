
CONVERT := inkscape -w 1404 -h 1872
OBJ := dailyplanner_jens.png dailyplanner_kristin.png
HOST = root@10.11.99.1

.PHONY: upload

all: $(OBJ)

$(OBJ): %.png : %.svg
	$(CONVERT) $(basename $@).svg -o $@

upload: $(OBJ)
	scp *.svg *.png templates.json $(HOST):/usr/share/remarkable/templates/
	ssh $(HOST) systemctl restart xochitl
