package oneDollarRec;

/*Pseudo code source
 * http://depts.washington.edu/madlab/proj/dollar/dollar.pdf
 * */

import java.awt.Point;
import java.util.ArrayList;

public class oneDollarRec {

	/*
	 * Resample a points path into n evenly spaced points. We use n=64. For
	 * gestures serving as templates, Steps 1-3 should be carried out once on
	 * the raw input points. For candidates, Steps 1-4 should be used just after
	 * the candidate is articulated.
	 */
	ArrayList<Point> resample(ArrayList<Point> points, int n) {
		float I = points.size() / (n - 1);
		double d;
		int D = 0;
		ArrayList<Point> newPoints = new ArrayList<Point>();
		newPoints.add(points.get(0));
		for (int i = 1; i < points.size(); i++) {
			Point prec = newPoints.get(newPoints.size() - 1);
			Point p = points.get(i);
			d = distance(prec, p);
			if ((D + d) >= I) {
				double qx = prec.getX() + ((I - D) / d) * (p.getX() - prec.getX());
				double qy = prec.getY() + ((I - D) / d) * (p.getY() - prec.getY());
				Point q = new Point((int) Math.round(qx), (int) Math.round(qy));
				newPoints.add(q);
				points.remove(i);
				points.add(i, q);
				D = 0;
			} else {
				D += d;
			}
		}
		return newPoints;
	}

	double distance(Point prec, Point p) {
		double d = 0;
		d = Math.sqrt((p.getY() - prec.getY()) * (p.getY() - prec.getY())
				+ (p.getX() - prec.getX()) * (p.getX() - prec.getX()));
		return d;
	}

	double pathLength(ArrayList<Point> A) {
		double d = 0.0;
		for (int i = 1; i < A.size(); i++) {
			d += distance(A.get(i - 1), A.get(i));
		}
		return d;
	}

	/*
	 * Find and save the indicative angle w from the points centroid to first
	 * point. Then rotate by – w to set this angle to 0 degrees.
	 */

	double indicativeAngle(ArrayList<Point> points) {
		Point c = centroid(points);
		return Math.atan2(c.getY() - points.get(0).getY(), c.getX() - points.get(0).getX());
	}

	/*
	 * Source: https://bit.ly/2RVqTFx
	 */
	Point centroid(ArrayList<Point> points) {
		double centroidX = 0, centroidY = 0;
		for (Point p : points) {
			centroidX += p.getX();
			centroidY += p.getY();
		}
		return new Point((int) Math.round(centroidX / points.size()), (int) Math.round(centroidY / points.size()));
	}

	ArrayList<Point> rotateBy(ArrayList<Point> points, double w) {
		Point c = centroid(points);
		double qx, qy;
		Point q;
		ArrayList<Point> newPoints = new ArrayList<Point>();
		for (Point p : points) {
			qx = (p.getX() - c.getX()) * Math.cos(w) - (p.getY() - c.getY()) * Math.sin(w) + c.getX();
			qy = (p.getX() - c.getX()) * Math.sin(w) - (p.getY() - c.getY()) * Math.cos(w) + c.getY();
			q = new Point((int) Math.round(qx), (int) Math.round(qy));
			newPoints.add(q);
		}
		return newPoints;
	}

	/*
	 * Scale points so that the resulting bounding box will be of size 2 size.
	 * We use size =250. Then translate points to the origin k =(0,0).
	 * BOUNDING-BOX returns a rectangle defined by ( min x , min y ), ( max x ,
	 * max y ).
	 */
	ArrayList<Point> scaleTo(ArrayList<Point> points, int size) {
		ArrayList<Point> newPoints = new ArrayList<Point>();
		double qx, qy;
		Point q;
		ArrayList<Integer> B = boundingBox(points);
		int bWidth = Math.abs(B.get(0) - B.get(2));
		int bHeight = Math.abs(B.get(1) - B.get(3));
		for (Point p : points) {
			qx = p.getX() - (size / bWidth);
			qy = p.getY() - (size / bHeight);
			q = new Point((int) Math.round(qx), (int) Math.round(qy));
			newPoints.add(q);
		}
		return newPoints;
	}

	/* Bounding box */
	ArrayList<Integer> boundingBox(ArrayList<Point> points) {
		int xmin = 1000, xmax = -1000, ymin = 1000, ymax = -1000;
		for (Point p : points) {
			if (p.getX() > xmax) {
				xmax = (int) Math.round(p.getX());
			} else if (p.getX() < xmin) {
				xmin = (int) Math.floor(p.getX());
			}
			if (p.getY() > ymax) {
				ymax = (int) Math.round(p.getY());
			} else if (p.getX() < ymin) {
				ymin = (int) Math.floor(p.getY());
			}
		}
		ArrayList<Integer> tmp = new ArrayList<Integer>();
		tmp.add(xmin);
		tmp.add(ymin);
		tmp.add(xmax);
		tmp.add(ymax);
		return tmp;
	}

	ArrayList<Point> translateTo(ArrayList<Point> points, Point k) {
		ArrayList<Point> newPoints = new ArrayList<Point>();
		double qx, qy;
		Point q;
		Point c = centroid(points);
		for (Point p : points) {
			qx = p.getX() + k.getX() - c.getX();
			qy = p.getY() + k.getY() - c.getY();
			q = new Point((int) Math.round(qx), (int) Math.round(qy));
			newPoints.add(q);
		}
		return newPoints;
	}

	/*
	 * Match points against a set of templates. The size variable on line 7 of
	 * RECOGNIZE refers to the size passed to SCALE-TO in Step 3. The symbol phi
	 * equals 0.5(-1 + sqrt 5). We use omega =+/-45degrees and omega delta
	 * =2degrees on line 3 of RECOGNIZE. Due to using RESAMPLE , we can assume
	 * that A and B in PATH-DISTANCE contain the same number of points, i.e., |
	 * A |=| B |.
	 */

}
