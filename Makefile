
CONVERT := inkscape -w 1404 -h 1872 
OBJ := dailyplanner_jens.png dailyplanner_kristin.png
HOST = root@10.11.99.1
OPTIONS := -o ConnectTimeout=1 -o PasswordAuthentication=no -o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostKeyAlgorithms=+ssh-rsa

.PHONY: upload

all: $(OBJ)

$(OBJ): %.png : %.svg
	$(CONVERT) $(basename $@).svg -o $@

upload: $(OBJ)
	#scp ${OPTIONS} *.svg *.png templates.json $(HOST):/usr/share/remarkable/templates/
	scp ${OPTIONS} *.svg *.png $(HOST):/usr/share/remarkable/templates/
	ssh ${OPTIONS} $(HOST) systemctl restart xochitl
	ssh ${OPTIONS} $(HOST) systemctl restart xochitl
