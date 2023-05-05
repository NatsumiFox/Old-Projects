using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _testing {
	class Program {
		static void Main(string[] args) {
			Player player = new Player("Jussi", 20f, 1f);
			Enemy enemy = new Enemy("Jani", 50f, 5f);
			enemy.Hurt(player);
			enemy.Equip(new Weapon("trout", 2f, 1.2f));
			enemy.Hurt(player);
			enemy.Equip(new Weapon("insult", 4f, 1.6f));
			enemy.Hurt(player);
			Console.ReadKey();
		}
	}

	public class GameObject {
		public string Name;
		public float Health, Strength;

		public GameObject(string name, float health, float strength) {
			Name = name;
			Health = health;
			Strength = strength;
		}
	}

	public class Enemy : GameObject {
		public Weapon weapon;

		public Enemy(string name, float health, float strength) : base(name, health, strength) {
			weapon = new Weapon("fist", 0, 0.1f);
		}

		public void Equip(Weapon wp) {
			weapon = wp;
		}

		public void Hurt(GameObject obj) {
			float realdmg = (Strength * weapon.StrengthMod) + weapon.Damage;
			obj.Health -= realdmg;

			if(obj.Health < 0) {
				Console.WriteLine($"{obj.Name} was killed by {Name} using {weapon.Name}!");

			} else {
				Console.WriteLine($"Health of {obj.Name} was reduced to {obj.Health} by {Name} using {weapon.Name}!");
			}
		}
	}

	public class Weapon {
		public float Damage, StrengthMod;
		public string Name;

		public Weapon(string name, float dmg, float str) {
			Name = name;
			Damage = dmg;
			StrengthMod = str;
		}
	}

	public class Player : GameObject {
		public Player(string name, float health, float strength) : base(name, health, strength) {

		}
	}
}
