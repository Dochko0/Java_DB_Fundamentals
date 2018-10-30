package b_CarShop;

public class Seat extends AbstractCar implements Sellable {
    Double getPrice;

    Seat(String model, String color, int horsePower, String countryProduced, double getPrice) {
        super(model, color, horsePower, countryProduced);
        this.getPrice=getPrice;
    }


    @Override
    public Double getPrice() {
        return this.getPrice;
    }


    @Override
    public String toString() {
        return "Seat price is " + getPrice + " Leva";
    }
}
