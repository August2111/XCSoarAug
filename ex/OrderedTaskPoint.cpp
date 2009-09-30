/* Generated by Together */

#include "OrderedTaskPoint.hpp"
#include "TaskLeg.h"
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "ConvexHull/GrahamScan.hpp"
#include "ConvexHull/PolygonInterior.hpp"


void OrderedTaskPoint::default_boundary_points() { 
  double t=0;
  if (boundary_scored) {
    for (t=0; t<1.0; t+= 0.05) {
      SEARCH_POINT sp;
      sp.Location = get_boundary_parametric(t);
      sp.actual = false;
      sp.saved_rank = 0;
      boundary_points.push_back(sp);
    }
  } else {
    SEARCH_POINT sp;
    sp.Location = getLocation();
    sp.actual = false;
    sp.saved_rank = 0;
    boundary_points.push_back(sp);
  }
}


const std::vector<SEARCH_POINT>& 
OrderedTaskPoint::get_boundary_points() const
{
  return boundary_points;
}


const std::vector<SEARCH_POINT>& 
OrderedTaskPoint::get_search_points()
{
  if (active_state== BEFORE_ACTIVE) {
    if (!sampled_points.size()) {

      // this adds a point in case the waypoint was skipped
      // this is a crude way of handling the situation --- may be best
      // to de-rate the score in some way

      SEARCH_POINT sp;
      sp.Location = getLocation();
      sp.actual = false;
      sp.saved_rank = 0;
      sampled_points.push_back(sp);
    }
    return sampled_points;
  } else if ((active_state == CURRENT_ACTIVE) && (sampled_points.size()>0)) {
    return sampled_points;
  } else {
    return boundary_points;
  }
}


GEOPOINT OrderedTaskPoint::get_reference_remaining_destination()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_travelled_origin()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_scored_destination()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_nominal_destination()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_travelled_destination()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_scored_origin()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_remaining_origin()
{
  return getLocation();
}
GEOPOINT OrderedTaskPoint::get_reference_nominal_origin()
{
  return getLocation();
}


TaskLeg* OrderedTaskPoint::get_leg_in() {
  return leg_in;
}

TaskLeg* OrderedTaskPoint::get_leg_out() {
  return leg_out;
}

void OrderedTaskPoint::set_leg_in(TaskLeg* the_leg)
{
  leg_in = the_leg;
}

void OrderedTaskPoint::set_leg_out(TaskLeg* the_leg) {
  leg_out = the_leg;
}

bool OrderedTaskPoint::scan_active(OrderedTaskPoint* atp) {
  // reset
  active_state = NOTFOUND_ACTIVE;

  if (atp == this) {
    active_state = CURRENT_ACTIVE;
  } else if (leg_in 
             && ((leg_in->get_origin()->getActiveState() 
                  == CURRENT_ACTIVE) 
                 || (leg_in->get_origin()->getActiveState() 
                     == AFTER_ACTIVE))) {
    active_state = AFTER_ACTIVE;
  } else {
    active_state = BEFORE_ACTIVE;
  }

  if (leg_out) { 
    // propagate to remainder of task
    return leg_out->get_destination()->scan_active(atp);
  } else if (active_state == BEFORE_ACTIVE) {
    return false;
  } else {
    return true;
  }
}

//////////////////

double OrderedTaskPoint::scan_distance_remaining(const GEOPOINT &ref) 
{
  // distance remaining from the given task point
  // (accumulates towards start)

  if (leg_out) {
    double d = leg_out->leg_distance_remaining(ref);
    distance_remaining = 
      leg_out->get_destination()->scan_distance_remaining(ref)
      +d;
  } else {
    // finish, reset
    distance_remaining = 0.0;
  }
  return distance_remaining;
}


////

double OrderedTaskPoint::scan_distance_nominal() 
{
  // distance from start to the task point
  // (accumulates towards finish)

  if (!leg_in) {
    // start, reset
    distance_nominal = 0.0;
  }
  if (leg_out) {
    double d = leg_out->leg_distance_nominal();
    leg_out->get_destination()->
      set_distance_nominal(d+distance_nominal);
    return leg_out->get_destination()->scan_distance_nominal();
  } else {
    // return at end
    return distance_nominal;
  }
}

double OrderedTaskPoint::scan_distance_travelled(const GEOPOINT &ref) 
{
  if (leg_in) {
    distance_travelled = leg_in->leg_distance_travelled(ref)
      +leg_in->get_origin()->distance_travelled;
  } else {
    distance_travelled = 0;
  }
  if (leg_out) {
    return leg_out->get_destination()->scan_distance_travelled(ref);
  } else {
    return distance_travelled;
  }
}


double OrderedTaskPoint::scan_distance_scored(const GEOPOINT &ref) 
{
  if (leg_in) {
    distance_scored = leg_in->leg_distance_scored(ref)
      +leg_in->get_origin()->distance_scored;
  } else {
    distance_scored = 0;
  }
  if (leg_out) {
    return leg_out->get_destination()->scan_distance_scored(ref);
  } else {
    return distance_scored;
  }
}



bool OrderedTaskPoint::prune_boundary_points()
{
  bool changed=false;
  GrahamScan gs(boundary_points);
  boundary_points = gs.prune_interior(&changed);
  return changed;
}


bool OrderedTaskPoint::prune_sample_points()
{
  bool changed=false;
  GrahamScan gs(sampled_points);
  sampled_points = gs.prune_interior(&changed);
  return changed;
}


bool OrderedTaskPoint::update_sample(const GEOPOINT& location)
{
  if (isInSector(location)) {
    // if sample is inside sample polygon
    //   return false (no update required)
    // else
    //   add sample to polygon
    //   re-compute convex hull
    //   return true; (update required)
    //
    if (PolygonInterior(location, sampled_points)) {
      printf("interior\n");
      // do nothing
      return false;
    } else {
      SEARCH_POINT sp;
      sp.Location = location;
      sp.actual = true;
      sp.saved_rank = 0;
      sampled_points.push_back(sp);
      // only return true if hull changed 
      return (prune_sample_points());
    }
  }
  return false;
}
