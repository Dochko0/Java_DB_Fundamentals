package b_CarShop;

public class Audi extends AbstractCar implements Rentable{
    int minRentDays;
    Double pricePerDay;

    public Audi(String model, String color, int horsePower, String countryProduced, int minRentDays, Double pricePerDay) {
        super(model, color, horsePower, countryProduced);
        this.minRentDays = minRentDays;
        this.pricePerDay = pricePerDay;
    }

    @Override
    public Integer getMinRentDay() {
        return this.minRentDays;
    }

    @Override
    public Double getPricePerDay() {
        return this.pricePerDay;
    }

    @Override
    public String toString() {
        return "Audi can be rent for minimum" + minRentDays + " days, with price: " + pricePerDay + " Leva";
    }
}
