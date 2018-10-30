package b_CarShop;

public abstract class AbstractCar implements Car {
    private String model;
    private String color;
    private int horsePower;
    private String countryProduced;


    AbstractCar(String model, String color, int horsePower, String countryProduced) {
        setModel(model);
        setColor(color);
        setHorsePower(horsePower);
        setCountryProduced(countryProduced);
    }


    private void setCountryProduced(String countryProduced) {
    }

    @Override
    public String getModel() {
        return this.model;
    }
    private void setModel(String model) {
        this.model=model;
    }

    @Override
    public String getColor() {
        return this.color;
    }
    private void setColor(String color) {
        this.color=color;
    }

    @Override
    public int getHorsePower() {
        return this.horsePower;
    }
    private void setHorsePower(int horsePower) {
        this.horsePower = horsePower;
    }
}
