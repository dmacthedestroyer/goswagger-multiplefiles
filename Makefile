TARGET := ./output

default: explicitpet

clean:
	rm -rf $(TARGET)
	mkdir $(TARGET)


explicitpet: clean
	swagger generate server -f swagger-explicitpet.yml -t $(TARGET)

nestedpet: clean
	swagger generate server -f swagger-nestedpet.yml -t $(TARGET)

urlpet: clean
	swagger generate server -f swagger-urlpet.yml -t $(TARGET)
