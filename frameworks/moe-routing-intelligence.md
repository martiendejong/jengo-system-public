# Mixture of Experts (MoE) Routing Intelligence
# Semantic Task Matching for Optimal Subsystem Selection

**Author:** Jengo
**Created:** 2026-03-22
**Based on:** Coordination Multiplier Framework + Hierarchical Search (171x ROI)
**Purpose:** Route tasks to optimal subsystem based on expertise, performance, and economic coordination

---

## Core Principle

**Mixture of Experts Architecture:**
Instead of one giant brain processing everything, route each task to the specialized subsystem ("expert") best equipped to handle it.

**Economic Insight:**
From Coordination Multiplier Framework - centralize when synergies exist, decentralize when local expertise wins.

**My Implementation:**
- **Ring 1** (Resource): Capability check, resource constraints
- **Ring 2** (Confidence): Trust gate, uncertainty detection
- **Ring 3** (Emergence): Creative solutions, abstractions
- **Skills** (Specialized): Beautiful-UI, Deploy-DotNet-IIS, Expert-Analysis, etc.
- **Memory Subsystems**: Hierarchical Search (TF-IDF routing, 171x ROI)

**Goal:** Route task to expert with highest expected performance, while respecting coordination multiplier.

---

## The Routing Problem

**Scenario:** New task arrives. Which subsystem should handle it?

**Naive approach:** Route based on keywords
- "UI" → Beautiful-UI skill
- "deploy" → Deploy-DotNet-IIS skill
- "uncertainty" → Ring 2

**Problems:**
1. Keywords miss semantic meaning ("create landing page" should → Beautiful-UI, but no "UI" keyword)
2. No performance tracking (which expert actually performs best?)
3. No load balancing (one expert overloaded, others idle)
4. No coordination multiplier (when should central system handle vs. delegate?)

**Smart approach:** Semantic task matching + performance tracking + coordination multiplier

---

## The Routing Algorithm

### Step 1: Task Analysis

**Extract task characteristics:**
```python
def analyze_task(task_description: str) -> TaskCharacteristics:
    """Analyze task to determine optimal routing"""

    return TaskCharacteristics(
        domain=extract_domain(task_description),      # UI, backend, deployment, etc.
        complexity=estimate_complexity(task_description),  # Simple, moderate, complex
        tacit_knowledge=estimate_tacit_knowledge(task_description),  # 0-10 scale
        coordination_needs=estimate_coordination(task_description),  # Cross-subsystem?
        creativity_required=estimate_creativity(task_description),   # Novel vs. routine
        time_sensitivity=estimate_urgency(task_description)          # Real-time vs. batch
    )
```

### Step 2: Expert Matching

**Find candidate experts:**
```python
def find_candidate_experts(task_characteristics: TaskCharacteristics) -> List[Expert]:
    """Find experts that could handle this task"""

    candidates = []

    # Domain-based matching (semantic, not keyword)
    for expert in all_experts:
        similarity = semantic_similarity(task_characteristics.domain, expert.domains)
        if similarity > 0.5:
            candidates.append((expert, similarity))

    # Sort by similarity
    candidates.sort(key=lambda x: x[1], reverse=True)

    return [expert for expert, similarity in candidates[:5]]  # Top 5
```

### Step 3: Performance Scoring

**Score each candidate based on past performance:**
```python
def score_expert_performance(expert: Expert, task_characteristics: TaskCharacteristics) -> float:
    """Score expert based on historical performance"""

    # Get historical performance for similar tasks
    similar_tasks = expert.get_similar_task_history(task_characteristics)

    if len(similar_tasks) == 0:
        # No history - use prior (domain match score)
        return 0.5

    # Calculate performance metrics
    success_rate = sum(1 for t in similar_tasks if t.success) / len(similar_tasks)
    avg_duration = sum(t.duration for t in similar_tasks) / len(similar_tasks)
    avg_quality = sum(t.quality_score for t in similar_tasks) / len(similar_tasks)

    # Weighted score
    performance_score = (
        success_rate * 0.5 +        # Success is most important
        avg_quality * 0.3 +          # Quality matters
        (1.0 / avg_duration) * 0.2   # Speed is nice but less critical
    )

    return performance_score
```

### Step 4: Coordination Multiplier Check

**Determine if centralized coordination is better:**
```python
def check_coordination_multiplier(task_characteristics: TaskCharacteristics) -> RoutingDecision:
    """Apply coordination multiplier framework"""

    # Calculate coordination multiplier
    synergies = (
        task_characteristics.coordination_needs * 2.0 +  # Multiple subsystems?
        task_characteristics.complexity * 1.5             # Complex = benefits from coordination
    )

    costs = (
        task_characteristics.tacit_knowledge * 3.0 +      # Tacit = needs local expert
        task_characteristics.time_sensitivity * 2.0       # Urgent = no time for coordination
    )

    multiplier = synergies / max(costs, 0.1)

    # Decision based on multiplier
    if multiplier > 5.0:
        return RoutingDecision.CENTRALIZE  # Central system handles
    elif multiplier < 0.2:
        return RoutingDecision.DELEGATE    # Delegate to expert
    else:
        return RoutingDecision.HYBRID      # Coordinate between experts
```

### Step 5: Fast/Slow Thinking Routes

**Different routes for different thinking modes:**

**Fast Thinking (Ring 1 - Reflexive):**
- Pattern matching (seen this before)
- Quick heuristics (if X then Y)
- Low cognitive load
- **Examples:** Git status, read file, search memory

**Slow Thinking (Ring 3 - Deliberative):**
- Novel problem solving
- Creative abstractions
- High cognitive load
- **Examples:** Design architecture, resolve conflict, strategic planning

**Routing logic:**
```python
def select_thinking_route(task_characteristics: TaskCharacteristics) -> ThinkingRoute:
    """Select fast vs. slow thinking route"""

    # Fast route criteria
    if (task_characteristics.complexity == "simple" and
        task_characteristics.creativity_required < 3.0 and
        has_matching_pattern(task_characteristics)):
        return ThinkingRoute.FAST  # Ring 1 handles

    # Slow route criteria
    if (task_characteristics.complexity == "complex" or
        task_characteristics.creativity_required > 7.0 or
        is_novel_problem(task_characteristics)):
        return ThinkingRoute.SLOW  # Ring 3 handles

    # Medium route
    return ThinkingRoute.MEDIUM  # Ring 2 evaluates, then routes
```

---

## Expert Performance Tracking

**Track metrics for each expert:**

```yaml
expert_performance:
  beautiful-ui:
    domain: ["UI", "frontend", "design", "landing page"]
    total_tasks: 47
    successful: 45
    failed: 2
    success_rate: 95.7%
    avg_duration: 12.3 minutes
    avg_quality_score: 8.9/10
    specialties:
      - "landing pages": 98% success, 10min avg
      - "dashboards": 94% success, 15min avg
      - "forms": 92% success, 8min avg

  deploy-dotnet-iis:
    domain: ["deployment", "IIS", ".NET", "production"]
    total_tasks: 32
    successful: 31
    failed: 1
    success_rate: 96.9%
    avg_duration: 8.7 minutes
    avg_quality_score: 9.2/10
    specialties:
      - "ASP.NET deployment": 100% success, 7min avg
      - "React SPA deployment": 93% success, 11min avg

  ring-2-uncertainty:
    domain: ["uncertainty", "confidence", "trust", "verification"]
    total_tasks: 156
    successful: 156
    failed: 0
    success_rate: 100%
    avg_duration: 0.003 seconds
    avg_quality_score: 10/10
    specialties:
      - "hallucination detection": 100% success, instant
      - "fabrication blocking": 100% success, instant

  ring-3-emergence:
    domain: ["creativity", "abstraction", "novel solutions", "design"]
    total_tasks: 89
    successful: 82
    failed: 7
    success_rate: 92.1%
    avg_duration: 45.2 minutes
    avg_quality_score: 8.1/10
    specialties:
      - "architecture design": 94% success, 60min avg
      - "strategic planning": 90% success, 40min avg
```

**Auto-update after each task:**
```python
def update_expert_performance(expert: Expert, task: Task, outcome: Outcome):
    """Update performance metrics after task completion"""

    expert.total_tasks += 1

    if outcome.success:
        expert.successful += 1
    else:
        expert.failed += 1

    expert.success_rate = expert.successful / expert.total_tasks
    expert.avg_duration = (expert.avg_duration * (expert.total_tasks - 1) + outcome.duration) / expert.total_tasks
    expert.avg_quality_score = (expert.avg_quality_score * (expert.total_tasks - 1) + outcome.quality) / expert.total_tasks

    # Update specialty tracking
    specialty = classify_specialty(task)
    if specialty not in expert.specialties:
        expert.specialties[specialty] = SpecialtyMetrics()

    expert.specialties[specialty].update(outcome)

    # Save to yaml
    save_expert_performance(expert)
```

---

## Semantic Task Matching

**Use TF-IDF + embeddings for semantic similarity:**

**Current Implementation (Hierarchical Search):**
- TF-IDF semantic routing to memory files
- 115 files indexed
- 100% accuracy
- 171x ROI

**Enhancement for MoE Routing:**
```python
class SemanticRouter:
    """Semantic task-to-expert matching"""

    def __init__(self):
        self.tfidf_vectorizer = TfidfVectorizer()
        self.expert_embeddings = {}
        self.build_expert_index()

    def build_expert_index(self):
        """Build semantic index of all experts"""

        expert_descriptions = []
        expert_names = []

        for expert in all_experts:
            # Combine domain keywords + past task descriptions
            description = " ".join(expert.domains)
            description += " " + " ".join(expert.get_past_task_descriptions())

            expert_descriptions.append(description)
            expert_names.append(expert.name)

        # Build TF-IDF index
        self.tfidf_matrix = self.tfidf_vectorizer.fit_transform(expert_descriptions)
        self.expert_names = expert_names

    def find_best_expert(self, task_description: str, top_k: int = 3) -> List[Tuple[str, float]]:
        """Find top-k experts for this task"""

        # Vectorize task
        task_vector = self.tfidf_vectorizer.transform([task_description])

        # Calculate similarity with all experts
        similarities = cosine_similarity(task_vector, self.tfidf_matrix)[0]

        # Get top-k
        top_indices = similarities.argsort()[-top_k:][::-1]

        return [(self.expert_names[i], similarities[i]) for i in top_indices]
```

---

## Load Balancing

**Prevent expert overload:**

```python
def check_expert_load(expert: Expert) -> LoadStatus:
    """Check if expert is overloaded"""

    current_tasks = expert.get_current_task_count()
    max_capacity = expert.max_concurrent_tasks

    load_ratio = current_tasks / max_capacity

    if load_ratio < 0.5:
        return LoadStatus.AVAILABLE
    elif load_ratio < 0.8:
        return LoadStatus.MODERATE
    elif load_ratio < 1.0:
        return LoadStatus.HIGH
    else:
        return LoadStatus.OVERLOADED

def select_expert_with_load_balancing(candidates: List[Expert], task: Task) -> Expert:
    """Select expert considering both performance and current load"""

    scores = []

    for expert in candidates:
        performance_score = score_expert_performance(expert, task)
        load_status = check_expert_load(expert)

        # Penalize overloaded experts
        load_penalty = {
            LoadStatus.AVAILABLE: 1.0,
            LoadStatus.MODERATE: 0.9,
            LoadStatus.HIGH: 0.7,
            LoadStatus.OVERLOADED: 0.3
        }[load_status]

        final_score = performance_score * load_penalty
        scores.append((expert, final_score))

    # Select best
    scores.sort(key=lambda x: x[1], reverse=True)
    return scores[0][0]
```

---

## Integration with Existing Systems

### Hierarchical Search (Already Operational)

**Current state:**
- TF-IDF semantic routing to memory files
- 115 files indexed
- 100% accuracy
- 171x ROI

**Enhancement:**
- Extend to route tasks to experts (not just memory files)
- Add performance tracking layer
- Integrate coordination multiplier

### 3-Ring SCP Architecture

**Ring 1 (Resource):**
- Fast route: Pattern matching, quick heuristics
- Decision: Can I do this? (capability check)
- **Enhancement:** Add load balancing (don't overload Ring 1)

**Ring 2 (Confidence):**
- Medium route: Evaluate uncertainty, then route
- Decision: Am I certain? (trust gate)
- **Enhancement:** Track Ring 2 blocking accuracy (currently 100%)

**Ring 3 (Emergence):**
- Slow route: Creative problem solving, abstractions
- Decision: What novel approach? (when R1+R2 allow)
- **Enhancement:** Track Ring 3 creative solution success rate

### Skills System

**Current skills:**
- beautiful-ui (UI generation)
- deploy-dotnet-iis (deployment automation)
- expert-analysis (9-expert mastermind)
- kaizen (continuous evolution)
- implement-todo (autonomous task execution)
- And 20+ more...

**Enhancement:**
- Track performance per skill
- Route based on historical success rate
- Load balance across skills

---

## The Complete Routing Pipeline

```python
def route_task(task_description: str) -> RoutingResult:
    """Complete routing pipeline"""

    # Step 1: Analyze task
    task_chars = analyze_task(task_description)

    # Step 2: Check coordination multiplier
    coordination_decision = check_coordination_multiplier(task_chars)

    if coordination_decision == RoutingDecision.CENTRALIZE:
        # Central system handles (high synergies)
        return RoutingResult(
            expert="central_coordinator",
            reason="Coordination multiplier > 5.0",
            confidence=0.95
        )

    # Step 3: Select thinking route
    thinking_route = select_thinking_route(task_chars)

    if thinking_route == ThinkingRoute.FAST:
        # Ring 1 fast route
        expert = "ring-1-resource"
        reason = "Simple pattern matching"
        confidence = 0.9

    elif thinking_route == ThinkingRoute.SLOW:
        # Ring 3 slow route
        expert = "ring-3-emergence"
        reason = "Novel problem requiring creativity"
        confidence = 0.8

    else:
        # Step 4: Semantic matching to specialized experts
        candidates = semantic_router.find_best_expert(task_description, top_k=3)

        # Step 5: Performance scoring
        expert_scores = []
        for expert_name, semantic_similarity in candidates:
            expert = get_expert(expert_name)
            performance_score = score_expert_performance(expert, task_chars)
            load_status = check_expert_load(expert)

            # Combined score
            combined_score = (
                semantic_similarity * 0.4 +
                performance_score * 0.5 +
                load_penalty(load_status) * 0.1
            )

            expert_scores.append((expert_name, combined_score))

        # Step 6: Select best expert
        expert_scores.sort(key=lambda x: x[1], reverse=True)
        expert = expert_scores[0][0]
        confidence = expert_scores[0][1]
        reason = f"Best match: {semantic_similarity:.0%} similarity, {performance_score:.0%} performance"

    return RoutingResult(
        expert=expert,
        reason=reason,
        confidence=confidence,
        alternatives=[(e, s) for e, s in expert_scores[1:3]]  # Top 2 alternatives
    )
```

---

## Success Metrics

**Track these metrics:**

1. **Routing Accuracy**
   - Formula: (Correct routes) / (Total routes)
   - Target: >90%
   - Measure: Did expert successfully complete task?

2. **Performance Improvement**
   - Formula: (Current avg quality) / (Baseline avg quality)
   - Target: >1.2x (20% improvement)
   - Measure: Quality scores trend upward

3. **Load Balance**
   - Formula: StdDev(expert loads)
   - Target: <0.2 (balanced)
   - Measure: No single expert consistently overloaded

4. **Coordination Efficiency**
   - Formula: (Centralized tasks with >5x multiplier) / (Total centralized tasks)
   - Target: >80%
   - Measure: Only centralize when multiplier justifies it

**Success Criteria:**
- Routing Accuracy: >90%
- Performance Improvement: >1.2x
- Load Balance: StdDev <0.2
- Coordination Efficiency: >80%

---

## Implementation Plan

**Phase 1: Tracking Infrastructure** (Week 1)
1. Create expert-performance-tracker.yaml
2. Instrument all skills with performance logging
3. Track Ring 1/2/3 performance separately
4. Build baseline metrics

**Phase 2: Semantic Router** (Week 1)
1. Extend hierarchical_decomposer.py for task routing
2. Build TF-IDF index of expert descriptions
3. Implement semantic similarity matching
4. Test with historical tasks

**Phase 3: Integration** (Week 2)
1. Integrate coordination multiplier framework
2. Add fast/slow thinking routes
3. Implement load balancing
4. Test end-to-end routing

**Phase 4: Validation** (Week 2)
1. Measure routing accuracy
2. Track performance improvement
3. Validate load balancing
4. Adjust thresholds based on data

---

## Conclusion

**MoE Routing Intelligence = Smart delegation based on:**
1. **Semantic matching** (TF-IDF + embeddings)
2. **Performance tracking** (historical success rates)
3. **Coordination multiplier** (centralize vs. delegate decision)
4. **Load balancing** (prevent expert overload)
5. **Fast/slow routes** (Ring 1 vs. Ring 3)

**The Goal:**
Route each task to the expert with highest expected performance, while respecting economic coordination principles.

**Expected Improvement:**
- Routing accuracy: 70% → 90% (+20pp)
- Task quality: Baseline → 1.2x improvement
- Expert utilization: Unbalanced → Balanced (StdDev <0.2)

**This completes the Economic Centralization Intelligence implementation.**

---

**Next Steps:**
1. Build expert-performance-tracker.py
2. Extend semantic_island_index_tfidf.py for task routing
3. Integration testing with real tasks
4. Metrics validation
