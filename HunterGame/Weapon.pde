public class Weapon {

  private int maxBulletsCount;
  private int bulletsCount;
  private int maxDistance;
  private int damage;

  public Weapon(int maxBulletsCount, int maxDistance, int damage) {
    this.maxBulletsCount = maxBulletsCount;
    this.bulletsCount = maxBulletsCount;
    this.maxDistance = maxDistance;
    this.damage = damage;
  }

  public Bullet makeShot(PVector startPosition, PVector direction) {
    if (bulletsCount > 0) {
      bulletsCount--;

      return new Bullet(startPosition, direction.normalize(), maxDistance, damage);
    }

    return null;
  }

  public int getMaxBulletCount() {
    return maxBulletsCount;
  }

  public int getBulletCount() {
    return bulletsCount;
  }

  public void setBulletCount(int bulletsCount) {
    this.bulletsCount = bulletsCount;
  }

  public int getMaxDistance() {
    return maxDistance;
  }

  public int getDamage() {
    return damage;
  }
}
