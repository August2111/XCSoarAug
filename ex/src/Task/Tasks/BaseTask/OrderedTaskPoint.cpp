#include "OrderedTaskPoint.hpp"
#include "Math/Earth.hpp"
#include <assert.h>
#include <math.h>


OrderedTaskPoint::OrderedTaskPoint(ObservationZonePoint* _oz,
                                   const TaskProjection& tp,
                                   const Waypoint & wp, 
                                   const TaskBehaviour &tb,
                                   const bool b_scored): 
  TaskLeg(*this),
  ScoredTaskPoint(tp, wp, tb, b_scored),
  ObservationZoneClient(_oz),
  m_active_state(NOTFOUND_ACTIVE),
  tp_next(NULL),
  tp_previous(NULL)
{
}


OrderedTaskPoint* 
OrderedTaskPoint::get_previous() const
{
  return tp_previous;
}

OrderedTaskPoint* 
OrderedTaskPoint::get_next() const
{
  return tp_next;
}


void 
OrderedTaskPoint::set_neighbours(OrderedTaskPoint* prev,
                                 OrderedTaskPoint* next) 
{
  tp_previous = prev;
  tp_next = next;

  update_geometry();
}


/** 
 * Update observation zone geometry (or other internal data) when
 * previous/next turnpoint changes.
 */
void 
OrderedTaskPoint::update_geometry() {
  set_legs(tp_previous, this, tp_next);
}


void
OrderedTaskPoint::update_oz()
{
  update_geometry();

  /// \todo also clear search points?
  SampledTaskPoint::update_oz();
}


bool 
OrderedTaskPoint::scan_active(OrderedTaskPoint* atp) 
{
  // reset
  m_active_state = NOTFOUND_ACTIVE;

  if (atp == this) {
    m_active_state = CURRENT_ACTIVE;
  } else if (tp_previous 
             && ((get_previous()->getActiveState() 
                  == CURRENT_ACTIVE) 
                 || (get_previous()->getActiveState() 
                     == AFTER_ACTIVE))) {
    m_active_state = AFTER_ACTIVE;
  } else {
    m_active_state = BEFORE_ACTIVE;
  }

  if (tp_next) { 
    // propagate to remainder of task
    return get_next()->scan_active(atp);
  } else {
    return (m_active_state != BEFORE_ACTIVE) && (m_active_state != NOTFOUND_ACTIVE);
  }
}


bool
OrderedTaskPoint::search_boundary_points()
{
  return m_active_state == AFTER_ACTIVE;
}

bool
OrderedTaskPoint::search_nominal_if_unsampled()
{
  return m_active_state == BEFORE_ACTIVE;
}

#ifdef INSTRUMENT_TASK
extern unsigned count_distbearing;
#endif


double 
OrderedTaskPoint::double_leg_distance(const GEOPOINT &ref) const
{
  assert(tp_previous);
  assert(tp_next);

#ifdef INSTRUMENT_TASK
  count_distbearing++;
#endif

  return ::DoubleDistance(get_previous()->get_location_remaining(), 
                          ref, 
                          get_next()->get_location_remaining());
}


bool 
OrderedTaskPoint::equals(const OrderedTaskPoint* other) const
{
  return (get_waypoint() == other->get_waypoint()) &&
    get_oz()->equals(other->get_oz());
}

