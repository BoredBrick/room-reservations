package room;

public class Room {
    private int id;
    private String name;
    private int capacity;
    private String building;
    private boolean hasProjector;
    private boolean hasWhiteboard;
    private boolean hasWifi;
    private String imagePath;

    public Room(int id, String name, int capacity, String building, boolean hasProjector, boolean hasWhiteboard, boolean hasWifi, String imagePath) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.building = building;
        this.hasProjector = hasProjector;
        this.hasWhiteboard = hasWhiteboard;
        this.hasWifi = hasWifi;
        this.imagePath = imagePath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public boolean hasProjector() {
        return hasProjector;
    }

    public void setHasProjector(boolean hasProjector) {
        this.hasProjector = hasProjector;
    }

    public boolean hasWhiteboard() {
        return hasWhiteboard;
    }

    public void setHasWhiteboard(boolean hasWhiteboard) {
        this.hasWhiteboard = hasWhiteboard;
    }

    public boolean hasWifi() {
        return hasWifi;
    }

    public void setHasWifi(boolean hasWifi) {
        this.hasWifi = hasWifi;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}

