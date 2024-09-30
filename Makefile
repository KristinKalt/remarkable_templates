
CONVERT := inkscape -w 1404 -h 1872 
OBJ := dailyplanner_jens.png dailyplanner_kristin.png
HOST = root@10.11.99.1
OPTIONS := -o ConnectTimeout=1 -o PasswordAuthentication=no -o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostKeyAlgorithms=+ssh-rsa

.PHONY: upload

all: $(OBJ)

$(OBJ): %.png : %.svg
	$(CONVERT) $(basename $@).svg -o $@

upload: $(OBJ)
	@scp ${OPTIONS} $(HOST):/usr/share/remarkable/templates/templates.json templates.json 
	@jq '.templates += input' templates.json custom_templates.json > .tmp.json && mv .tmp.json templates.json
	scp ${OPTIONS} *.png templates.json $(HOST):/usr/share/remarkable/templates/
	@rm templates.json
	@ssh ${OPTIONS} $(HOST) systemctl restart xochitl
	@ssh ${OPTIONS} $(HOST) systemctl restart xochitl
