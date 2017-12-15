TARGET := ./output

default: explicitpet

clean:
	rm -rf $(TARGET)
	mkdir $(TARGET)

catfilename: clean
	swagger generate server -f swagger-cat-filename.yaml -t $(TARGET)

cheshiresfilename: clean
	swagger generate server -f swagger-cheshires-filename.yaml -t $(TARGET)

explicitpet: clean
	swagger generate server -f swagger-explicitpet.yml -t $(TARGET)

nestedpet: clean
	swagger generate server -f swagger-nestedpet.yml -t $(TARGET)

urlpet: clean
	swagger generate server -f swagger-urlpet.yml -t $(TARGET)
