using System;
using System.Collections.Generic;

namespace SMPS_maker {
	public class Node : Element {
		private List<Element> ele;
		public string Name;

		public Node() {
			ele = new List<Element>();
		}

		public virtual string GetName() {
			return Name;
		}

		public virtual bool SetName(string n) {
			Name = n;
			return true;
		}

		public int ElementCount() {
			return ele.Count;
		}

		public bool hasElement(Element e) {
			return ele.Contains(e);
		}

		public int indexOfElement(Element e) {
			return ele.IndexOf(e);
		}

		public void addElementLast(Element e) {
			addElement(e, ElementCount());
		}

		public void addElementFirst(Element e) {
			addElement(e, 0);
		}

		public List<Element> Get() {
			return ele;
		}

		public bool addElement(Element e, Element q) {
			if (!hasElement(q)) {
				return false;
			}

			addElement(e, indexOfElement(q));
			return true;
		}

		public void addElement(Element e, int pos) {
			ele.Insert(pos, e);
		}
	}
}