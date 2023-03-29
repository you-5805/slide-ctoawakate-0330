SLIDES=ctoawakate-0330

build: $(addprefix build_, $(SLIDES))

.PHONY: build_%
build_%:
	npm slidev build ./src/entries/$(@:build_%=%).md --out ../../dist/$(@:build_%=%)
